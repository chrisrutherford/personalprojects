library(shiny)
library(shinydashboard)
library(colourpicker)
library(plotrix)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- dashboardPage(skin = "green",
                    
    # Application title
    dashboardHeader(title = "Probability Simulations",
                    titleWidth = 250),
    
    # navigation sidebar
    dashboardSidebar(sidebarMenu(
        menuItem("Dice", tabName = "dice", icon = icon("dice")),
        menuItem("Coins", tabName = "coins", icon = icon("coins")),
        menuItem("Darts", tabName = "darts", icon = icon("bullseye")),
        menuItem("Random Walk", tabName = "walk", icon = icon("arrows-alt")
        )
    )),
    dashboardBody(tabItems(
        tabItem(
            tabName = "dice",
            fluidRow(column(
                4, h4(textOutput("diceTitle")), htmlOutput("diceText")
            ),
            column(8, plotOutput("dicePlot"))),
            fluidRow(
                column(
                    4,
                    sliderInput(
                        inputId = "diceNum",
                        label = "Number of dice",
                        value = 1,
                        min = 1,
                        max = 20
                    ),
                    numericInput(
                        inputId = "rolls",
                        label = "Number of rolls",
                        value = 50,
                        min = 1,
                        max = 10000
                    )
                ),
                column(
                    4,
                    selectInput(
                        inputId = "plotSelect",
                        label = "Plot to display",
                        choices = c("Barplot", "Running average"),
                        selected = "Barplot"
                    ),
                    checkboxInput(inputId = "fitLine", label =
                                      "Display theoretical line"),
                    conditionalPanel(
                        condition = "input.fitLine",
                        sliderInput(
                            inputId = "theoWidth",
                            label = "Line width",
                            min = 1,
                            max = 10,
                            value = 2
                        ),
                        colourInput(
                            inputId = "theoColor",
                            label = "Line color",
                            value = "#FF0000"
                        )
                    )
                ),
                column(
                    4,
                    colourInput(
                        inputId = "barcol",
                        label = "Bar/line color",
                        value = "#0000FF"
                    ),
                    conditionalPanel(
                        condition = "input.plotSelect=='Barplot'",
                        colourInput(
                            inputId = "outline",
                            label = "Bar outline color",
                            value = "#000000"
                        ),
                        sliderInput(
                            inputId = "barWidth",
                            label = "Bar outline width",
                            value = 2,
                            max = 10,
                            min = 1
                        )
                    ),
                    conditionalPanel(
                        condition = "input.plotSelect=='Running average'",
                        sliderInput(
                            inputId = "avgWidth",
                            label = "Sample average line width",
                            min = 1,
                            max = 10,
                            value = 2
                        )
                    )
                )
            )
        ),
        tabItem(tabName = "coins",
                fluidRow(
                    column(4, h4(textOutput("coinTitle")),htmlOutput("coinText")),
                    column(8, plotOutput("coinPlot"))),
                fluidRow(
                    column(
                        4,
                        sliderInput(
                            inputId = "coins",
                            label = "Number of coins",
                            value = 1,
                            min = 1,
                            max = 20
                        ),
                        numericInput(
                            inputId = "flips",
                            label = "Number of coin flips",
                            value = 10,
                            min = 1,
                            max = 10000
                        )
                    ),
                    column(
                        4,
                        checkboxInput(inputId = "fitLine2", label = "Display theoretical line"),
                        conditionalPanel(
                            condition = "input.fitLine2",
                            sliderInput(
                                inputId = "theoWidth2",
                                label = "Line width",
                                min = 1,
                                max = 10,
                                value = 2
                            ),
                            colourInput(
                                inputId = "theoColor2",
                                label = "Line color",
                                value = "#FF0000"
                            )
                        )
                    ),
                    column(
                        4,
                        colourInput(
                            inputId = "barcol2",
                            label = "Bar/line color",
                            value = "#0000FF"
                        ),
                        colourInput(
                            inputId = "outline2",
                            label = "Bar outline color",
                            value = "FFFF00"
                        ),
                        sliderInput(
                            inputId = "barWidth2",
                            label = "Bar outline width",
                            value = 1,
                            max = 10,
                            min = 1
                        )
                    )
                )),
        tabItem(tabName = "darts",
                fluidRow(
                    column(4, h4(textOutput("dartsTitle")),htmlOutput("dartsText")),
                    column(8, plotOutput("dartsPlot"))),
                fluidRow(
                    column(4,
                           numericInput(inputId="darts",label="Number of darts",
                                        value=0,min=0,max=10000),
                           sliderInput(inputId="vAcc",label="Veritcal accuracy",
                                       value=0,min=0,max=1),
                           sliderInput(inputId="hAcc",label="Horizontal accuracy",
                                       value=0,min=0,max=1),
                           helpText("An accuracy of 0 is completely random, while
                        an accuracy of 1 places the darts into a perfectly straight line.
                                    Setting both to zero centers all of the darts.")),
                    column(4,
                           sliderInput(inputId="largeRd",label="Radius of large circle",
                                       min=0,max=1,value=1),
                           sliderInput(inputId="medRd",label="Radius of medium circle",
                                       min=0,max=1,value=0.6),
                           sliderInput(inputId="smallRd",label="Radius of small circle",
                                       min=0,max=1,value=0.25)),
                    column(4,
                           colourInput(inputId="largeCol",label="Color of large circle",
                                       value="FF0000"),
                           sliderInput(inputId="largeAlpha",label="Opacity",
                                       min=0,max=1,value=0.4),
                           colourInput(inputId="medCol",label="Color of medium circle",
                                       value="00FF00"),
                           sliderInput(inputId="medAlpha",label="Opacity",
                                       min=0,max=1,value=0.4),
                           colourInput(inputId="smallCol",label="Color of small circle",
                                       value="0000FF"),
                           sliderInput(inputId="smallAlpha",label="Opacity",
                                       min=0,max=1,value=0.4))
                )),
        tabItem(tabName = "walk",
                fluidRow(
                    column(4, h4(textOutput("walkTitle")),htmlOutput("walkText")),
                    column(8, plotOutput("walkPlot"))),
                fluidRow(
                    column(4,
                           selectInput(inputId="walkType",label="Dimensions of walk",
                                       choices=c("1D","2D"),
                                       selected="1D"),
                           helpText("1D walks are only up and down, while 2D walks are
                        up, down, left, and right."),
                           conditionalPanel(
                               condition="input.walkType==`1D`",
                               numericInput(inputId="steps1D",label="Steps to take",
                                            min=1,max=10000,value=10),
                               numericInput(inputId="probUp1",
                                            label="Probability of increasing by 1",
                                            min=0,max=1,value=0.5),
                               numericInput(inputId="probDown1",
                                            label="Probability of decreasing by 1",
                                            min=0,max=1,value=0.5)),
                           conditionalPanel(
                               condition="input.walkType==`2D`",
                               numericInput(inputId="steps2D",label="Steps to take",
                                            min=1,max=10000,value=10),
                               numericInput(inputId="probUp2",
                                            label="Probability of moving up 1 unit",
                                            min=0,max=1,value=0.25),
                               numericInput(inputId="probDown2",
                                            label="Probability of moving down 1 unit",
                                            min=0,max=1,value=0.25),
                               numericInput(inputId="probLeft2",
                                            label="Probability of moving right 1 unit",
                                            min=0,max=1,value=0.25),
                               numericInput(inputId="probRight2",
                                            label="Probability of moving left 1 unit",
                                            min=0,max=1,value=0.25))),
                    column(4,
                           conditionalPanel(
                               condition="input.walkType==`1D`",
                               checkboxInput(inputId="theoWalk",label="Show theoretical walk")),
                           conditionalPanel(
                               condition="input.theoWalk & input.walkType==`1D`",
                               sliderInput(inputId="theoWalkWidth",label="Theoretical line width",
                                           min=1,max=10,value=2),
                               colourInput(inputId="theoWalkColor",label="Theoretical line color",
                                           value="0000DD")),
                           conditionalPanel(
                               condition="input.walkType==`2D`",
                               checkboxInput(inputId="aspect",label="Maintain aspect ratio",
                                             value=F),
                               checkboxInput(inputId="startPt",label="Show starting point",
                                             value=F),
                               checkboxInput(inputId="endPt",label="Show ending point",
                                             value=F)),
                           conditionalPanel(
                               condition="input.startPt & input.walkType==`2D`",
                               colourInput(inputId="startCol",label="Starting point color",
                                           value="00DD00"),
                               sliderInput(inputId="startSize",label="Starting point size",
                                           min=1,max=5,value=2)),
                           conditionalPanel(
                               condition="input.endPt & input.walkType==`2D`",
                               colourInput(inputId="endCol",label="Ending point color",
                                           value="0000FF"),
                               sliderInput(inputId="endSize",label="Ending point size",
                                           min=1,max=5,value=2))
                    ),
                    column(4,
                           sliderInput(inputId="dispWidth",label="Line width",
                                       min=1,max=10,value=2),
                           colourInput(inputId="dispColor",label="Line color",
                                       value="AA0000"),
                           conditionalPanel(
                               condition="input.walkType==`2D`",
                               sliderInput(inputId="dispAlpha",label="Line opacity",
                                           min=0,max=1,value=1))
                    )
                ))
    )  #close tabItems
    ) #close dashboardBody
    
)#final closing parenthesis

# Define server logic required to draw a histogram
server <- function(input, output, session) {
    
    # Title for rolling dice
    output$diceTitle <- renderText({
        "Rolling Dice"
    })
    
    # Info for rolling dice
    output$diceText <- renderUI({
        s1 = "Rolling dice is one of the most basic and common examples of how probability
    works in the real world.<br>"
        
        s2 = "The sliders below customize how many dice are thrown in each roll,
    how many times to throw the die/dice, and other aesthetics.
    When more than one die is rolled, the sum of the roll is used. <br>"
        
        s3 = "For 2 dice, the plot follows a triangular distribution. For 3 dice,
    the graph begins to smooth out and becomes approximately normal as more
    dice are rolled per roll."
        HTML(paste(s1, s2, s3, sep = "<br>"))
    })
    
    # Plot for rolling dice
    output$dicePlot <- renderPlot({
        par(bg = NA)
        validate(need(input$rolls > 0, "Number of rolls must be greater than 0"))
        set.seed(123)
        x = 0
        if (input$diceNum > 1) {
            for (i in 1:input$diceNum) {
                y = sample(
                    x = 1:6,
                    size = input$rolls,
                    replace = T
                )
                x = y + x
            }
        }
        else{
            x = sample(x = 1:6,
                       size = input$rolls,
                       replace = T)
        }
        EX = input$diceNum * 3.5
        runAvg = cumsum(x)
        n = c(1:input$rolls)
        pts = round(runAvg / n, 3)
        xlimits = c(0, input$rolls)
        ylimits = c(min(pts), max(pts))
        means = paste("Sample mean:", round(mean(x), 3),
                      "Theoretical mean:", EX)
        
        if (input$diceNum == 1) {
            xlabel = paste("Number Rolled on Die")
        }
        else {
            xlabel = paste("Sum of Rolling", input$diceNum, "Dice")
        }
        
        if (input$plotSelect == "Barplot") {
            par(lwd = input$barWidth)
            barplot(
                table(x),
                col = input$barcol,
                main = "Barplot of Dice Rolls",
                border = input$outline,
                xlab = xlabel,
                ylab = "Frequency",
                sub = means
            )
            if (input$fitLine) {
                par(new = T, lwd = input$theoWidth)
                if (input$diceNum > 2) {
                    xBound = seq(min(x), max(x), length.out = 500)
                    fit = dnorm(xBound, mean(x), sd(x))
                    plot(
                        xBound,
                        fit,
                        xlab = "",
                        ylab = "",
                        main = "",
                        axes = F,
                        type = 'l',
                        col = input$theoColor
                    )
                }
                else if (input$diceNum == 1) {
                    abline(h = input$rolls / 6,
                           col = input$theoColor)
                }
                else{
                    xBound = seq(2, 12, length.out = 201)
                    fit = ifelse(xBound >= 7, (14 - xBound), xBound)
                    plot(
                        xBound,
                        fit,
                        xlab = "",
                        ylab = "",
                        main = "",
                        axes = F,
                        type = 'l',
                        col = input$theoColor,
                        xlim = range(x)
                    )
                }
            }
        }
        else if (input$plotSelect == "Running average") {
            par(lwd = input$avgWidth)
            plot(
                x = pts,
                col = input$barcol,
                xlim = xlimits,
                ylim = ylimits,
                type = 'l',
                main = "Running Average of Dice Rolls",
                xlab = "Roll number",
                ylab = "Running Average",
                sub = paste(
                    "Current running average:",
                    pts[input$rolls],
                    "Theoretical average:",
                    EX
                )
            )
            if (input$fitLine) {
                par(lwd = input$theoWidth)
                abline(
                    h = EX,
                    col = input$theoColor,
                    lwd = input$theoWidth
                )
            }
        }
    })
    
    
    # Title for coin flip
    output$coinTitle <- renderText({
        "Flipping Coins"
    })
    
    # Info for coin flip
    output$coinText <- renderUI({
        s1 = "Flipping coins is another common way of demonstrating probability.
    Such an experiment follows a binomial distribution, and flipping multiple
    coins also follows a binomial distribution. <br>"
        
        s2 = "This experiment shows just how common or uncommon a certain amount
    of heads actually is when flipping a certain amount of coins. <br>"
        
        s3 = "Use the sliders to customize how many coins to flip
    and how many coins are flipped in each trial.  <br>"
        
        HTML(paste(s1, s2, s3, sep = "<br>"))
    })
    
    # Plot for coin flip
    output$coinPlot <- renderPlot({
        par(bg = NA)
        validate(need(
            input$flips > 1,
            "Number of coin flips must be greater than 1"
        ))
        set.seed(123)
        x = 0
        for (i in 1:input$coins) {
            y = sample(x = 0:1,
                       size = input$flips,
                       replace = T)
            x = y + x
        }
        EX = input$flips * 0.5
        par(lwd = input$barWidth2)
        barplot(
            table(x),
            col = input$barcol2,
            main = "Barplot of Number of Heads",
            border = input$outline2,
            xlab = "Number of Heads",
            ylab = "Frequency",
            sub = paste(
                "Sample mean:",
                round(mean(x), 3),
                "Theoretical mean:",
                round(input$coins * 0.5, 3)
            )
        )
        if (input$fitLine2) {
            par(new = T, lwd = input$theoWidth2)
            if (input$coins > 1) {
                xBound = seq(min(x), max(x), length.out = 500)
                fit = dnorm(xBound, mean(x), sd(x))
                plot(
                    xBound,
                    fit,
                    xlab = "",
                    ylab = "",
                    main = "",
                    axes = F,
                    type = 'l',
                    col = input$theoColor2
                )
            }
            else {
                abline(h = EX, col = input$theoColor2)
            }
        }
    })
    
    
    # Title for darts
    output$dartsTitle <- renderText({
        "Dart Throwing Simulation"
    })
    
    # Info for darts
    output$dartsText <- renderUI({
        s1 = "This simulation uses randomly plotted points as darts and the circles
    as a dartboard. The amount of darts, size of each circle, and other
    aesthetics can be adjusted with the sliders below. <br>"
        
        s2 = "The x and y coordinates of the darts are both normally distributed.
    The accuracy slider adjusts how far from the mean (center) the darts may end up. <br>"
        
        HTML(paste(s1, s2, sep = "<br>"))
    })
    
    # Update circle sizes for darts
    observe({
        # set max of medium circle slider to size of large circle
        val = input$largeRd
        updateSliderInput(session,
                          inputId = "medRd",
                          min = 0,
                          max = val)
        
        # set max of small circle slider to size of medium circle
        val2 = input$medRd
        updateSliderInput(session,
                          inputId = "smallRd",
                          min = 0,
                          max = val2)
        
        
    })
    
    # Plot for darts
    output$dartsPlot <- renderPlot({
        par(bg = NA)
        set.seed(123)
        validate(need(
            input$darts >= 0,
            "Number of darts must be greater than or equal to 0"
        ))
        x = rnorm(input$darts,
                  mean = 0,
                  sd = (1 - input$hAcc) / 2.5)
        y = rnorm(input$darts,
                  mean = 0,
                  sd = (1 - input$vAcc) / 2.5)
        outsideCount = sum(x ^ 2 + y ^ 2 > input$largeRd ^ 2)
        largeCount = sum(x ^ 2 + y ^ 2 <= input$largeRd ^ 2)
        medCount = sum(x ^ 2 + y ^ 2 <= input$medRd ^ 2)
        smallCount = sum(x ^ 2 + y ^ 2 <= input$smallRd ^ 2)
        xlabel = paste(
            "Darts outside circles:",
            outsideCount,
            "   Darts in large circle:",
            largeCount,
            "\nDarts in medium circle:",
            medCount,
            "   Darts in small circle:",
            smallCount,
            "\n\n\n"
        )
        
        par(mar = c(1.1, 1.1, 1.1, 1.1))
        plot(
            0,
            0,
            xlab = '',
            ylab = '',
            axes = F,
            type = 'n',
            xlim = c(-1, 1),
            ylim = c(-1, 1),
            asp = 1
        )
        draw.circle(
            x = 0,
            y = 0,
            r = input$largeRd,
            col = alpha(input$largeCol, input$largeAlpha)
        )
        draw.circle(
            x = 0,
            y = 0,
            r = input$medRd,
            col = alpha(input$medCol, input$medAlpha)
        )
        draw.circle(
            x = 0,
            y = 0,
            r = input$smallRd,
            col = alpha(input$smallCol, input$smallAlpha)
        )
        par(new = T, mar = c(1.1, 1.1, 1.1, 1.1))
        if (input$darts) {
            plot(
                x,
                y,
                pch = 4,
                axes = F,
                xlab = xlabel,
                ylab = "",
                asp = 1,
                xlim = c(-1, 1),
                ylim = c(-1, 1)
            )
        }
        else{
            plot(
                0,
                0,
                type = 'n',
                axes = F,
                xlab = xlabel,
                ylab = "",
                asp = 1,
                xlim = c(-1, 1),
                ylim = c(-1, 1)
            )
        }
    })
    
    
    # Title for random walk
    output$walkTitle <- renderText({
        "Random Walks"
    })
    
    # Info for random walk
    output$walkText <- renderUI({
        s1 = "A random walk is a random process in which an object randomly 'walks'
    or moves away from a starting point. In the most basic case, an object
    starts on the number line at zero and has an equal chance of either
    increasing or decreasing by one every step.
    <br>"
        
        s2 = "This simulation will start the object at 0 and change by
    either 1 or -1 for each step. In 1-dimension steps, the graph
    represents the cumulative sum of the steps and shows the
    displacement of the object from the origin. The theoretical line
    is found by using the expected value of each step as the slope.
    <br>"
        
        s3 = "The probability of moving in a certain direction can be customized,
    but the probabilities must sum to 1."
        
        HTML(paste(s1, s2, s3, sep = "<br>"))
    })
    
    # Plot for random walk
    output$walkPlot <- renderPlot({
        par(bg = NA)
        set.seed(123)
        par(lwd = input$dispWidth)
        if (input$walkType == "1D") {
            validate(
                need(
                    input$steps1D > 0,
                    "Number of steps must greater than 0"
                ),
                need(
                    input$probUp1 + input$probDown1 == 1,
                    "Probabilities must sum to 1"
                )
            )
            walkProb1D = c(input$probUp1, input$probDown1)
            x = sample(
                x = c(1, -1),
                size = input$steps1D,
                replace = T,
                prob = walkProb1D
            )
            ylimits = c(min(cumsum(x)), max(cumsum((x))))
            
            plot(
                cumsum(x),
                main = "One Dimensional Random Walk",
                type = 'l',
                col = input$dispColor,
                sub = paste("Displacement from origin:", tail(cumsum(x), 1)),
                xlab = "Steps",
                ylab = "Displacement",
                ylim = ylimits
            )
            if (input$theoWalk) {
                par(lwd = input$theoWalkWidth)
                abline(
                    a = 0,
                    b = (input$probUp1) + (-input$probDown1),
                    col = input$theoWalkColor
                )
            }
        }
        else if (input$walkType == "2D") {
            validate(
                need(
                    input$probUp2 + input$probDown2 + input$probLeft2 + input$probRight2 == 1,
                    "Probabilities must sum to 1"
                ),
                need(
                    input$steps2D > 0,
                    "Number of steps must greater than 0"
                )
            )
            n = input$steps2D + 1
            walkProb2D = c(input$probUp2,
                           input$probDown2,
                           input$probLeft2,
                           input$probRight2)
            xDirec = yDirec = 0
            xPosition = yPosition = rep(0, n)
            xPosition[1] = yPosition[1] = 0
            x = sample(
                x = 1:4,
                size = n,
                replace = T,
                prob = walkProb2D
            )
            for (i in 1:(n - 1)) {
                if (x[i] == 1) {
                    yDirec = yDirec + 1
                }
                else if (x[i] == 2) {
                    yDirec = yDirec - 1
                }
                else if (x[i] == 3) {
                    xDirec = xDirec + 1
                }
                else if (x[i] == 4) {
                    xDirec = xDirec - 1
                }
                xPosition[i + 1] = xDirec
                yPosition[i + 1] = yDirec
            }
            if (input$aspect) {
                aspect = 1
            }
            else{
                aspect = NA
            }
            randWalk = cbind(xPosition, yPosition)
            plot(
                randWalk[, 1],
                randWalk[, 2],
                type = 'l',
                main = "Two Dimensional Random Walk",
                col = alpha(input$dispColor, input$dispAlpha),
                xlab = "Horizontal Displacement",
                ylab = "Vertical Displacement",
                xlim = range(randWalk[, 1]),
                ylim = range(randWalk[, 2]),
                asp = aspect
            )
            if (input$startPt) {
                points(
                    cbind(0, 0),
                    col = input$startCol,
                    cex = input$startSize,
                    pch = 20
                )
            }
            if (input$endPt) {
                end = cbind(randWalk[n, 1], randWalk[n, 2])
                points(
                    end,
                    col = input$endCol,
                    cex = input$endSize,
                    pch = 20
                )
            }
        } ## End of 2D walk
    })
}
shinyApp(ui = ui, server = server)
