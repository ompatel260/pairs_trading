#set document(title: "Pair Trading Under Regime Changes")
#set page(margin: 1in)
#set text(size: 12pt)
#set par(leading: 0.8em, spacing: 1.2em)

#align(center)[
  #text(size: 20pt, weight: "bold")[Pair Trading Under Regime Changes]
]
#align(center)[
  #text(size: 15pt, weight: "bold")[Om Patel]
]
= Role
I plan to be the primary researcher for this paper and get help from my advisor Professor Rajinda Wickrama throughout the lifespan of this project.
= 1. Introduction
Pair Trading is a well studied and used statistical arbitrage strategy in the field of quantitative finance. The fundamental idea of the method is to identify two assets whose prices move together in the long run. Then, when prices deviate from one another, traders profit by betting a return to equilibrium.

This project directly challenges this assumption. The typical approach to pairs trading uses co-integration tests to determine the pairs, and then trades as if the co-integrating vector is stable. The problem is that financial markets are non-stationary environments, and regimes change, funding liquidity changes, firms change, and the underlying fundamentals that tie two stocks together can erode and even cease to exist. When this happens, traders are exposed to huge, one-sided losses if they are trading based on a stable co-integrating vector assumption that is no longer valid.

The interesting fact is that, while there is a significant literature on pairs trading and a significant literature on regime-switching models, surprisingly little work directly addresses the time-stability of co-integrating vectors and the implications for strategy design. This project hopes to combine classical econometric testing with modern regime-switching approaches to answer a simple and important question: when, why, and how predictably do pairs trading relationships fail?
= 2. Research Questions
+ Are co-integrated pairs stable over time, or do their co-integrating vectors and mean-reversion speeds drift significantly over time and market conditions?
+ Does conditioning pairs trading on the estimated regime improve risk-adjusted performance relative to a naive unconditional strategy?

= 3. Literature Review
The most notable study on pairs trading is Gatev, Goetzmann, and Rouwenhorst (2006), who found excess returns from a basic distance-based pairs approach on US equity markets from 1962 to 2002. In the study, they assumed stability in pairs relationships and did not account for regime changes whatsoever. Vidyamurthy (2004) and Caldeira and Moura (2013) built on this paper by using co-integration-based pairs, to more rigorously test the pairs, but they still assumed a constant co-integrating relationship over time.

The econometric approach to parameter stability testing is well developed. Bai & Perron (1998, 2003) developed an extensive framework to test and estimate multiple unknown structural breaks in linear models, and this is easily extended potential breaks in asset prices moving together. Zivot & Andrews (1992) have developed a unit root test that allows for one endogenous break, which can be used to test the mean-reverting nature of the spread against a shifted level process. Using these approaches, we can better interpret regression results when there are structural changes in the data.

The literature on regime changes starts with Hamilton (1989), who developed the hidden Markov model approach to macroeconomic time series. Guidolin & Timmermann (2006) use Markov switching models to analyze international equity returns, and they find strong evidence of distinct bull and bear regimes each with unique return and volatility patterns. Extending regime-switching to the analysis of co-integrated systems, the MS-VECM, was developed by Krolzig (1997), and the model was used to analyze exchange rates and commodity markets, but this was not extended to equity pairs trading spreads.

More recently, in a study examining the profitability of pairs trading under different market conditions, Clegg & Krauss (2018) find that the performance of pair trading depends highly on regime, supporting the hypothesis that underlying co-integrating relationships are unstable. In the paper, however, there is no formal modeling or attempt to internalize the instability. This project hopes to model the unstable nature of pairs and find a way to predict it.

= 4. Data
== 4.1 Assets
This project hopes to look at 2 different categories of assets. 

ETFs in the same industry move in pairs due to underlying sector exposure causing prices to move together and these assets also have a long history of stock prices.

In addition to ETFs, the project will also look at large cap stocks in the same industry. The addition of individual large cap stocks allows for the model to measure idiosyncratic movements which ETFs would not. Data for all of these assets will be collected from 2000 to 2024 as the timeframe covers many different economic conditions such as recessions and bubbles.

Examples of the ETF pairs would be XLE/XOP (energy), XLF/KBE (financials), XLV/IBB (healthcare/biotech). For individual stocks, the examples would be Visa/Mastercard, Coca-Cola/PepsiCo, and ExxonMobil/Chevron.
== 4.2 Historical Economic Indicators
Data such as historical VIX, credit spreads, and market fear indicators will be compiled from 2000 to 2024 as a tool to predict different economic conditions.

= 5. Methodology
== 5.1 Test Co-integration
To check for which pairs will be used in the paper, we will apply a Johansen maximum likelihood co-integration test. Only pairs with long run equilibrium will be examined and their co-integrating vector ($beta$) and adjustment speed ($alpha$) will be noted.
== 5.2 Rolling Window Co-integration
Run Johansen maximum likelihood co-integration test for each trading day to find the co-integrating vector ($beta$) and adjustment speed ($alpha$) and using a 95% confidence interval see if the co-integration for the two assets ever breaks.
== 5.3 Test for Structural Breaks
Using a Bai-Perron test, find the dates for structural breaks in the co-integration. Once the dates of the structural breaks are found, try to match them with historical events such as 2008 Housing Crisis or certain idiosyncratic events in the case of individual stocks.
== 5.4 Markov-Switching Vector Error Correction Model
Instead of the typical assumption of one stable relationship between the assets, this paper will attempt to formulate a model which switches between regimes of strong and weak mean reversion. Making the model this way allows for the co-integration of the stocks to act differently depending on economic conditions.
== 5.5 Predicting Breakdowns
Using a logistic model, we will use data such as market volatility, credit spreads, and other applicable variables to predict the outcome of being in either a strong and weak mean reversion regime.

== 5.6 Back-testing
Using the predictive regime model created, compare the conventional pair trading strategy to one which considers the predicted regime by back-testing the strategies on historical market data. By back-testing, we can determine if accounting for regimes when trading pairs improves profitability and Sharpe ratio among other metrics. The back test would be on data from 2020 to 2025 and if time permits, it would include other similar assets that the model was not trained on to check the versatility of the model.


= 6. Timeline
Each week will likely require 15-20 hours of work and be broken into the following stages.

*June 1st - June 15th*: Get and clean data from Bloomberg Terminal and finish Literature Review section

*June 15th - June 30th*: Run co-integration tests and rolling window tests

*July 1st - July 15th*: Run structural break tests and matching break dates with historical events

*July 15th - July 30th*: Estimate the Markov-Switching Vector Error Correction Model and create the logistic model for predicting regimes

*August 1st - August 15th*: Run back-testing on basic pair trading and compare it with regime switching pair trading.

*August 15th - August 30th*: Compile results and write final paper

= 7. Connection to Academic and Professional Goals
This research project provides a progression to my academic background as an undergraduate student majoring in math and economics at the University of Delaware. By taking graduate-level mathematics and economics courses at the university, I have gained the knowledge base required for dealing with the methodologies discussed in this paper. Additionally, given the course offerings at the college, I've reached a point where there are very few courses left which would prepare me for my desired career of being a quantitive researcher. This project aims to help me not only apply what I've already learned, but to keep learning more with the help of my advisor, Professor Rajinda Wickrama, whose main area of research is financial mathematics, the field which underpins most of quantitative research in practice today.\

In terms of academics, this project is a synthesis of both mathematics and economics as it uses both high level statistics such as Markov Chains and econometric tools such as co-integration tests to answer research questions. Additionally, it also allows me to experience being a researcher first hand and gives me experience for going to graduate school. I have past experience working alongside others to do research for collegiate stock pitch competitions, however, I believe that by working on this paper and attempting to publish it, I will become much more comfortable and effective at conducting high level academic research. By growing as a researcher, I would be better prepared for graduate school and also for a career working in modelling the financial markets. \

This project aligns directly with my goal of becoming a quantitative researcher as it is extremely applicable to trading strategies currently used at hedge funds. This summer I will be interning at a hedge fund, where the concepts such strategy robustness, regime awareness, and risk-adjusted performance which are covered in my paper are central to daily tasks. The ability to not only implement but critically evaluate trading strategies will make me a stronger contributor during the internship and beyond when I work full-time. The project as a whole demonstrates the kind of independent, rigorous thinking that quantitative researcher roles demand. I hope this project serves as both a representation of my research capabilities and a foundation I can build on as I pursue a career in quantitative finance.

#pagebreak()
= Preliminary Biography
1.	Bai, J., & Perron, P. (1998). Estimating and testing linear models with multiple structural changes. Econometrica, 66(1), 47–78.
2.	Caldeira, J., & Moura, G. (2013). Selection of a portfolio of pairs based on cointegration: A statistical arbitrage strategy. Brazilian Review of Finance, 11(1), 49–80.
3.	Clegg, M., & Krauss, C. (2018). Pairs trading with partial cointegration. Quantitative Finance, 18(1), 121–138.
4.	Engle, R. F., & Granger, C. W. J. (1987). Co-integration and error correction: Representation, estimation, and testing. Econometrica, 55(2), 251–276.
5.	Gatev, E., Goetzmann, W. N., & Rouwenhorst, K. G. (2006). Pairs trading: Performance of a relative-value arbitrage rule. Review of Financial Studies, 19(3), 797–827.
6.	Guidolin, M., & Timmermann, A. (2006). An econometric model of nonlinear dynamics in the joint distribution of stock and bond returns. Journal of Applied Econometrics, 21(1), 1–22.
7.	Hamilton, J. D. (1989). A new approach to the economic analysis of nonstationary time series and the business cycle. Econometrica, 57(2), 357–384.
8.	Johansen, S. (1991). Estimation and hypothesis testing of cointegration vectors in Gaussian vector autoregressive models. Econometrica, 59(6), 1551–1580.
9.	Krolzig, H.-M. (1997). Markov-Switching Vector Autoregressions: Modelling, Statistical Inference, and Application to Business Cycle Analysis. Springer.
10.	Zivot, E., & Andrews, D. W. K. (1992). Further evidence on the great crash, the oil-price shock, and the unit-root hypothesis. Journal of Business & Economic Statistics, 10(3), 251–270.
