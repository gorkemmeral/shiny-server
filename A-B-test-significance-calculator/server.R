library(shiny)

# Define server 
shinyServer(function(input, output) {
	formulaText <- reactive({
		paste("Results for", input$variable, "%", "Confidence Level")
	})
	output$caption <- renderText({
		formulaText()
	})
	
	output$Confidence_intervalA <- renderText({
		A_visitors <- input$Avisitors
		A_conversions <- input$Aconversions
		conversion_rateA = A_conversions/A_visitors
		#conversion_rateA
		seA <- sqrt(conversion_rateA*(1-conversion_rateA)/	A_visitors)
		if (input$variable == '95'){
		Confidence_A <-c(conversion_rateA - 1.28*seA,  conversion_rateA + 1.28*seA)
		}
		else{
		Confidence_A <-c(conversion_rateA - 1.96*seA,  conversion_rateA + 1.96*seA)
		}
		paste("Conversion rate for control group is", round(conversion_rateA*100, digits = 2), "%") #, "with the", input$variable, "%","confidence interval", "[",round(Confidence_A[1], digits=3), ",", round(Confidence_A[2], digits=3),"]")
		
	})
		
	output$Confidence_intervalB <- renderText({		
		B_visitors <- input$Bvisitors
		B_conversions <- input$Bconversions

		#conversion rates
		conversion_rateB = B_conversions/B_visitors
		#conversion_rateB
		seB <- sqrt(conversion_rateB*(1-conversion_rateB)/B_visitors)
		if (input$variable == '95'){
		Confidence_B <-c(conversion_rateB - 1.28*seB,  conversion_rateB + 1.28*seB)
		}
		else{
		Confidence_B <-c(conversion_rateB - 1.96*seB,  conversion_rateB + 1.96*seB)
		}
		paste("Conversion rate for variation group is", round(conversion_rateB*100, digits = 2), "%") #"with the", input$variable, "%", "confidence interval", "[",round(Confidence_B[1], digits=3), ",", round(Confidence_B[2], digits=3),"]")
	})

	output$Zscore <- renderText({
		A_visitors <- input$Avisitors
		A_conversions <- input$Aconversions
		conversion_rateA = A_conversions/A_visitors
		seA <- sqrt(conversion_rateA*(1-conversion_rateA)/	A_visitors)
		B_visitors <- input$Bvisitors
		B_conversions <- input$Bconversions
		conversion_rateB = B_conversions/B_visitors
		seB <- sqrt(conversion_rateB*(1-conversion_rateB)/B_visitors)
		Z_score =  (conversion_rateB - conversion_rateA)/sqrt(seA**2 + seB**2)
		paste("z-score = ", round(Z_score,digits=3)) 
	})	
	
	output$pvalue <- renderText({
		A_visitors <- input$Avisitors
		A_conversions <- input$Aconversions
		conversion_rateA = A_conversions/A_visitors
		seA <- sqrt(conversion_rateA*(1-conversion_rateA)/	A_visitors)
		
		B_visitors <- input$Bvisitors
		B_conversions <- input$Bconversions
		conversion_rateB = B_conversions/B_visitors
		seB <- sqrt(conversion_rateB*(1-conversion_rateB)/B_visitors)
		Z_score =  (conversion_rateB - conversion_rateA)/sqrt(seA**2 + seB**2)
		
		p_value <- 1-pnorm(Z_score)
		paste("p-value = ", round(p_value, digits=3))
		
		
		if (input$variable == '95'){
			if (p_value < 0.05){
				paste("p-value = ", round(p_value, digits=3))				
			}
			else{
				paste("p-value = ", round(p_value, digits=3))
			}
		}
		else if (input$variable == '99'){
			if (p_value < 0.01){
				paste("p-value = ", round(p_value, digits=3))
			}
			else{
				paste("p-value = ", round(p_value, digits=3))
				}
				}
	})
	output$statement <- renderText({
		A_visitors <- input$Avisitors
		A_conversions <- input$Aconversions
		conversion_rateA = A_conversions/A_visitors
		seA <- sqrt(conversion_rateA*(1-conversion_rateA)/	A_visitors)
		
		B_visitors <- input$Bvisitors
		B_conversions <- input$Bconversions
		conversion_rateB = B_conversions/B_visitors
		seB <- sqrt(conversion_rateB*(1-conversion_rateB)/B_visitors)
		Z_score =  (conversion_rateB - conversion_rateA)/sqrt(seA**2 + seB**2)
		
		p_value <- 1-pnorm(Z_score)
		paste("p-value = ", round(p_value, digits=3))
		
		
		if (input$variable == '95'){
			if (p_value < 0.05){
				paste("<span style=\"color:green;font-size:160%\">Results are statistically significant</span")				
			}
			else{
				paste("<span style=\"color:red;font-size:160%\">Results are not statistically significant</span")
			}
		}
		else if (input$variable == '99'){
			if (p_value < 0.01){
				paste("<span style=\"color:green;font-size:160%\">Results are statistically significant</span")
			}
			else{
				paste("<span style=\"color:red;font-size:160%\">Results are not statistically significant</span")
				}
				}
	})
})
