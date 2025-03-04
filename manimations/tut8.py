# use ensure manim is installed to run this python script

from manim import *
import math as math
import numpy as np

class Tutorial8(Scene):
    def construct(self):
        ax1 = Axes(
            x_range=[-1.25, 1.25, .25],
            y_range=[-1.5, 1.5, 1],
            x_axis_config={
                "include_numbers": True,
                "font_size": 24
            },
            y_axis_config={
                "include_numbers": True,
                "font_size": 24
            },
        ).move_to([0, 2, 0]).scale(0.75)
        
        ax2 = Axes(
            x_range=[-1.25, 1.25, .25],
            y_range=[-1.5, 1.5, 1],
            x_axis_config={
                "include_numbers": True,
                "font_size": 24
            },
            y_axis_config={
                "include_numbers": True,
                "font_size": 24
            },
        ).move_to([0, -3, 0]).scale(0.75)
        
        # Add labels for each curve
        x_t_label = MathTex("x(t)", font_size=36, color=BLUE)
        x_t_label.next_to(ax1, LEFT)
        
        y_t_label = MathTex("y(t)", font_size=36, color=RED)
        y_t_label.next_to(ax2, LEFT)
        
        # Define the functions
        def func1_equation(x):
            return math.cos(2 * PI * x)
            
        def func2_equation(x):
            return abs(math.cos(2 * PI * x))
        
        # Plot the functions
        func1 = ax1.plot(func1_equation, color=BLUE)
        func2 = ax2.plot(func2_equation, color=RED)
        
        # Create trackers to control dot positions
        t1 = ValueTracker(-1.25)  # Start at the beginning of x-range
        t2 = ValueTracker(-1.25)
        
        # Create dots that follow the curves
        dot1 = always_redraw(
            lambda: Dot(
                ax1.c2p(t1.get_value(), func1_equation(t1.get_value())),
                color=YELLOW
            )
        )
        
        dot2 = always_redraw(
            lambda: Dot(
                ax2.c2p(t2.get_value(), func2_equation(t2.get_value())),
                color=YELLOW
            )
        )
        
        # Create a line connecting the two dots
        connecting_line = always_redraw(
            lambda: Line(
                start=dot1.get_center(),  # Start from center of dot1
                end=dot2.get_center(),    # End at center of dot2
                color=GREEN,              # Line color
                stroke_width=2            # Line thickness
            )
        )
        
        # Add everything to the scene
        self.add(ax1, ax2, func1, func2)
        self.add(x_t_label, y_t_label)  # Add the labels
        self.add(dot1, dot2, connecting_line)  # Add dots and the connecting line
        
        # Animate the dots along their respective curves
        self.play(
            t1.animate.set_value(1.25),  # Animate to the end of x-range
            t2.animate.set_value(1.25),
            run_time=5,  # 5 seconds animation
            rate_func=linear  # Constant speed
        )

from manim import *
import numpy as np

from manim import *
import numpy as np

class FourierVisualiser(Scene):
    def construct(self):
        # Create axes and original function without animation
        axes = Axes(
            x_range=[-1.25, 1.25, 0.25],
            y_range=[0, 1.5, 0.5],
        ).scale(0.9)
        
        # Original function (target)
        def rectified_cosine(x):
            return abs(np.cos(2 * PI * x))
        
        target_function = axes.plot(rectified_cosine, color=GRAY)
        
        # Add them to the scene without animation
        self.add(axes, target_function)
        
        # Fourier approximation functions
        def fourier_term(x, n):
            if n == 0:
                return 2/PI  # a₀ component
            else:
                coefficient = 4 * ((-1)**(n-1)) / (PI * (2*n - 1))
                return coefficient * np.cos(2 * PI * n * x)
        
        def fourier_approximation(x, terms):
            result = 0
            for n in range(terms + 1):
                result += fourier_term(x, n)
            return result
        
        # Start with just a₀
        current_terms = 0
        current_graph = axes.plot(
            lambda x: fourier_approximation(x, current_terms),
            color=RED
        )
        
        # Animate only the Fourier series
        self.play(Create(current_graph))
        
        # Show a₀ label above the graph in white
        a0_label = MathTex("a_0 = \\frac{2}{\\pi}", font_size=36, color=WHITE)
        a0_label.to_edge(UP, buff=0.5)  # Position at top
        self.play(FadeIn(a0_label))
        self.wait(1)
        
        # Add terms one by one
        coefficients = [
            "a_0 + a_1",
            "a_0 + a_1 + a_2",
            "a_0 + a_1 + a_2 + a_3",
            "a_0 + a_1 + a_2 + a_3 + a_4",
            "a_0 + a_1 + a_2 + \\ldots + a_{10}",
            "a_0 + a_1 + a_2 + \\ldots + a_{50}",
            "a_0 + a_1 + a_2 + \\ldots + a_{100}",
            "a_0 + a_1 + a_2 + \\ldots + a_{\\infty}"
        ]
        
        term_counts = [1, 2, 3, 4, 10, 50, 100, 300]  # Actual number of terms to use
        
        current_label = a0_label
        
        for i, (coef_text, terms) in enumerate(zip(coefficients, term_counts)):
            # Create new graph with more terms
            new_graph = axes.plot(
                lambda x: fourier_approximation(x, terms),
                color=RED
            )
            
            # Create new coefficient label in white
            new_label = MathTex(coef_text, font_size=36, color=WHITE)
            new_label.to_edge(UP, buff=0.5)  # Position at top
            
            # Animate transition
            self.play(
                Transform(current_graph, new_graph),
                Transform(current_label, new_label)
            )
            self.wait(1)
        
        # For the a_∞ case, transition to the exact function
        final_graph = axes.plot(
            rectified_cosine,
            color=RED
        )
        
        self.play(
            Transform(current_graph, final_graph),
            run_time=2
        )
        
        # Final highlighting
        self.play(
            current_graph.animate.set_color(GREEN),
            target_function.animate.set_stroke(opacity=0.7)
        )
        self.wait(2)