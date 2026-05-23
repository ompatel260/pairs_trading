import yfinance as yf
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Download S&P 500 data and compute monthly returns
sp500 = yf.download("SPY", start="1993-01-01", end="2024-12-31", auto_adjust=True)["Close"].iloc[:, 0]
sp500_returns = sp500.pct_change().dropna()

# Parameters
R_FREE = 0.05 
REBAL_FREQ = "ME" 
WINDOW_MONTHS = 12 

# Resample to monthly returns
monthly_sp500 = sp500_returns.resample(REBAL_FREQ).apply(lambda x: (1+x).prod() - 1)

# Prepare DataFrame for backtesting
df = pd.DataFrame({"r_risky": monthly_sp500}).dropna()
df["r_f_current"] = R_FREE / 12

# Compute rolling estimates of mean and variance for the risky asset
df["mu"]     = df["r_risky"].rolling(WINDOW_MONTHS).mean().shift(1)
df["sigma2"] = df["r_risky"].rolling(WINDOW_MONTHS).var().shift(1)
df = df.dropna()

# Annualize the estimates
df["mu_annual"]     = df["r_risky"].rolling(WINDOW_MONTHS).mean().shift(1) * 12
df["sigma2_annual"] = df["r_risky"].rolling(WINDOW_MONTHS).var().shift(1) * 12

# set a risk aversion parameter (gamma)
GAMMA = 7.0

# Compute Merton's optimal weight (leverage clipped to [0, 2] for practical reasons)
df["w_merton"] = (df["mu_annual"] - R_FREE) / (GAMMA * df["sigma2_annual"])
df["w_merton_clipped"] = df["w_merton"].clip(0, 2)

# Compute portfolio returns
df["port_return"]  = df["w_merton_clipped"] * df["r_risky"] + (1 - df["w_merton_clipped"]) * df["r_f_current"]
df["bond_return"]  = df["r_f_current"]
df["fifty_return"] = 0.5 * df["r_risky"] + 0.5 * df["r_f_current"]

# Compute cumulative wealth
df["wealth_merton"] = (1 + df["port_return"]).cumprod()
df["wealth_sp500"]  = (1 + df["r_risky"]).cumprod()
df["wealth_bond"]   = (1 + df["bond_return"]).cumprod()
df["wealth_fifty"]  = (1 + df["fifty_return"]).cumprod()

# Performance metrics
def sharpe(returns, rf, periods=12):
    excess = returns - rf
    return excess.mean() / excess.std() * np.sqrt(periods)

def max_drawdown(wealth):
    return ((wealth - wealth.cummax()) / wealth.cummax()).min()

# Print performance summary
print(f"{'Strategy':<12} {'Sharpe':>8} {'Max DD':>8} {'Ann Ret':>8}")
print("-" * 40)
for name, ret, wealth in [
    ("Merton",  df["port_return"],  df["wealth_merton"]),
    ("SP500",   df["r_risky"],      df["wealth_sp500"]),
    ("Bond",    df["bond_return"],  df["wealth_bond"]),
    ("50/50",   df["fifty_return"], df["wealth_fifty"]),
]:
    print(f"{name:<12} {sharpe(ret, df['r_f_current']):>8.2f} {max_drawdown(wealth):>8.1%} {(wealth.iloc[-1]**(12/len(df))-1):>8.1%}")

fig, axes = plt.subplots(3, 1, figsize=(12, 14))

ax = axes[0]
ax.plot(df.index, df["wealth_sp500"],  label="S&P 500",  color="steelblue")
ax.plot(df.index, df["wealth_merton"], label="Merton",   color="darkorange")
ax.plot(df.index, df["wealth_fifty"],  label="50/50",    color="green")
ax.plot(df.index, df["wealth_bond"],   label="Bond",     color="gray", linestyle="--")
ax.set_title("Cumulative Wealth ($1 invested in 1994)")
ax.set_ylabel("Portfolio Value ($)")
ax.legend()
ax.grid(alpha=0.3)

ax = axes[1]
ax.plot(df.index, df["w_merton_clipped"], color="darkorange")
ax.axhline(1.0, color="gray", linestyle="--", alpha=0.5, label="100% equities")
ax.axhline(0.5, color="green", linestyle="--", alpha=0.5, label="50/50")
ax.set_title("Merton Optimal Weight in S&P 500 Over Time")
ax.set_ylabel("Weight")
ax.legend()
ax.grid(alpha=0.3)

ax = axes[2]
for name, wealth, color in [
    ("S&P 500", df["wealth_sp500"],  "steelblue"),
    ("Merton",  df["wealth_merton"], "darkorange"),
    ("50/50",   df["wealth_fifty"],  "green"),
]:
    dd = (wealth - wealth.cummax()) / wealth.cummax()
    ax.plot(df.index, dd, label=name, color=color)
ax.set_title("Drawdowns")
ax.set_ylabel("Drawdown")
ax.legend()
ax.grid(alpha=0.3)

# Adjust layout and save figures showing performance of the Merton strategy compared to benchmarks
plt.tight_layout()
plt.savefig("backtest_results.png", dpi=150)
plt.show()