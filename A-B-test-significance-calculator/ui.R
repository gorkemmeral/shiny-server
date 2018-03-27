library(shiny)

shinyUI(pageWithSidebar(
	#Appl title
	headerPanel("A/B Test Statistical Significance Calculator"),
	sidebarPanel(
	span("Use this calculator to validate your hypothesis. Enter the results of your experiment below and click on the 'Calculate' button. This is a one-sided calculator; if the conversion rate of the variation group (B) is lower than the control group (A), no conclusive statement can be made."),
	br(), br(),
	span("Or return to", a(href = "http://gorkemmeral.com", "gorkemmeral.com")),
	hr(),
	selectInput("variable", "Select confidence level for significance",
	list("95%" = "95",
	"99%" = "99")), 
	
	numericInput("Avisitors", "Enter number of visitor for the control group (A)", 1000),
	numericInput("Bvisitors", "Enter number of visitors for the variation group (B)", 1000),
	numericInput("Aconversions", "Enter number of conversions for the control group (A)", 200),
	numericInput("Bconversions", "Enter number of conversions for the variation group (B)", 250),
	
	submitButton("Calculate"),
	hr(),
	span("Return to", a(href = "http://gorkemmeral.com", "gorkemmeral.com")),
	br(),
	span("Code forked from", a(href = "https://github.com/Jverma/Significance-in-A-B-testing", "here"))

	),
	
	mainPanel(
	h3(textOutput("caption")),
		verbatimTextOutput("Confidence_intervalA"),
		verbatimTextOutput("Confidence_intervalB"),
		verbatimTextOutput("Zscore"),
		verbatimTextOutput("pvalue"),
		htmlOutput("statement"),
		tags$head(
	tags$meta(name = "Description", content = "A/B test statistical significance calculator. Enter your test results, calculate the p-value and z-score, see if the results are statistically significant.")
	)
	)
	


))
