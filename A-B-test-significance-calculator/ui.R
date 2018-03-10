library(shiny)

shinyUI(pageWithSidebar(

	#Appl title
	headerPanel("A/B Test Statistical Significance Calculator"),
	
	sidebarPanel(
	span("Use this calculator to validate your hypothesis. Enter the results of your experiment below and click on the 'Calculate' button."),
	hr(),
	selectInput("variable", "Select confidence level for significance",
	list("95%" = "95",
	"99%" = "99")), 
	
	numericInput("Avisitors", "Enter number of visitor for the control group", 1000),
	numericInput("Bvisitors", "Enter number of visitors for the variation group", 1000),
	numericInput("Aconversions", "Enter number of conversions for the control group", 200),
	numericInput("Bconversions", "Enter number of conversions for the variation group", 200),
	
	submitButton("Calculate"),
	hr(),
	<strong>span("Return to", a(href = "http://gorkemmeral.com", "gorkemmeral.com"))<strong>,
	br(),
	span("Code forked from", a(href = "https://github.com/Jverma/Significance-in-A-B-testing", "here"))

	),
	
	mainPanel(
	h3(textOutput("caption")),
		verbatimTextOutput("Confidence_intervalA"),
		verbatimTextOutput("Confidence_intervalB"),
		verbatimTextOutput("Zscore"),
		verbatimTextOutput("pvalue")
	)

))
