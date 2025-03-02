import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class CheatSheetScreen extends StatelessWidget {
  const CheatSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fourier Series Cheat Sheet'),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Introduction
              CheatSheetSection(
                title: 'Fourier Series',
                content: 'A method to represent a periodic function as a sum of sine and cosine terms.'
              ),
              
              // Three Forms of Fourier Series
              CheatSheetSection(
                title: 'Fourier Series Forms',
                children: [
                  FormulaCard(
                    title: 'Trigonometric Form',
                    formula: r'f(t) = a_0 + \sum_{n=1}^{\infty} \left( a_n\cos(n\omega t) + b_n\sin(n\omega t) \right)',
                    details: [
                      r'a_0 = \frac{1}{T}\int_{0}^{T}f(t)dt',
                      r'a_n = \frac{2}{T}\int_{0}^{T}f(t)\cos(n\omega t)dt',
                      r'b_n = \frac{2}{T}\int_{0}^{T}f(t)\sin(n\omega t)dt',
                      r'\omega = \frac{2\pi}{T}',
                    ],
                  ),
                  
                  FormulaCard(
                    title: 'Amplitude-Phase Form',
                    formula: r'f(t) = A_0 + \sum_{n=1}^{\infty}A_n\cos(n\omega t - \phi_n)',
                    details: [
                      r'A_0 = a_0',
                      r'A_n = \sqrt{a_n^2 + b_n^2}',
                      r'\phi_n = \tan^{-1}\left(\frac{b_n}{a_n}\right)',
                    ],
                  ),
                  
                  FormulaCard(
                    title: 'Complex Exponential Form',
                    formula: r'f(t) = \sum_{n=-\infty}^{\infty}c_n e^{jn\omega t}',
                    details: [
                      r'c_n = \frac{1}{T}\int_{0}^{T}f(t)e^{-jn\omega t}dt',
                      r'c_0 = a_0',
                      r'c_n = \frac{a_n - jb_n}{2}, n > 0',
                      r'c_{-n} = \frac{a_n + jb_n}{2}, n > 0',
                    ],
                  ),
                ],
              ),
              
              // Signal Properties
              CheatSheetSection(
                title: 'Signal Properties',
                children: [
                  PropertyCard(
                    title: 'Periodicity',
                    content: 'A signal f(t) is periodic if f(t) = f(t+T) for some period T.',
                  ),
                  
                  PropertyCard(
                    title: 'Fundamental Frequency',
                    formula: r'f_0 = \frac{1}{T}, \omega_0 = \frac{2\pi}{T}',
                    content: 'The lowest frequency component in a periodic signal.',
                  ),
                  
                  PropertyCard(
                    title: 'Even & Odd Functions',
                    content: 'Even: f(-t) = f(t) → only cosine terms (bn = 0)\nOdd: f(-t) = -f(t) → only sine terms (an = 0)',
                  ),
                  
                  PropertyCard(
                    title: 'Half-Wave Symmetry',
                    content: 'f(t+T/2) = -f(t) → only odd harmonics exist',
                    formula: r'a_0 = a_{2k} = b_{2k} = 0, \text{ for } k = 1,2,3,...',
                  ),
                ],
              ),
              
              // Signal Operations
              CheatSheetSection(
                title: 'Signal Operations',
                children: [
                  PropertyCard(
                    title: 'Time Shifting',
                    content: 'If f(t) → {cn}, then f(t-τ) →',
                    formula: r'c_n e^{-jn\omega_0\tau}',
                    extraInfo: 'Magnitude unchanged, phase is shifted',
                  ),
                  
                  PropertyCard(
                    title: 'Time Scaling',
                    content: 'If f(t) has period T, then f(at) has period T/a',
                    formula: r'f(at) \Rightarrow \text{same coefficients, } \omega_0 \rightarrow a\omega_0',
                  ),
                  
                  PropertyCard(
                    title: 'Differentiation',
                    content: 'If f(t) → {cn}, then df/dt →',
                    formula: r'jn\omega_0 c_n',
                    extraInfo: 'Enhances higher harmonics',
                  ),
                  
                  PropertyCard(
                    title: 'Integration',
                    content: 'If f(t) → {cn}, then ∫f(t)dt →',
                    formula: r'c_n / (jn\omega_0), n \neq 0',
                    extraInfo: 'Attenuates higher harmonics',
                  ),
                ],
              ),
              
              // Common Waveforms
              CheatSheetSection(
                title: 'Common Waveforms',
                children: [
                  WaveFormCard(
                    title: 'Square Wave',
                    formula: r'f(t) = \frac{4}{\pi}\sum_{n=1,3,5,...}^{\infty}\frac{\sin(n\omega t)}{n}',
                    notes: 'Only odd harmonics, amplitudes decay as 1/n',
                  ),
                  
                  WaveFormCard(
                    title: 'Sawtooth Wave',
                    formula: r'f(t) = \frac{2}{\pi}\sum_{n=1}^{\infty}\frac{(-1)^{n+1}\sin(n\omega t)}{n}',
                    notes: 'All harmonics, amplitudes decay as 1/n',
                  ),
                  
                  WaveFormCard(
                    title: 'Triangle Wave',
                    formula: r'f(t) = \frac{8}{\pi^2}\sum_{n=1,3,5,...}^{\infty}\frac{(-1)^{\frac{n-1}{2}}\sin(n\omega t)}{n^2}',
                    notes: 'Only odd harmonics, amplitudes decay as 1/n²',
                  ),
                ],
              ),
              
              // Convergence Properties
              CheatSheetSection(
                title: 'Convergence Properties',
                children: [
                  PropertyCard(
                    title: 'Dirichlet Conditions',
                    content: 'For Fourier series convergence, a function must:\n- Be periodic\n- Have a finite number of discontinuities\n- Have a finite number of extrema\n- Be absolutely integrable',
                  ),
                  
                  PropertyCard(
                    title: 'Gibbs Phenomenon',
                    content: 'Overshoot occurs near discontinuities that doesn\'t vanish as more terms are added (remains ~9% of jump)',
                  ),
                  
                  PropertyCard(
                    title: 'Rate of Convergence',
                    content: 'Depends on smoothness of function:\n- Discontinuous function: Coefficients decay as 1/n\n- Continuous with discontinuous derivative: Coefficients decay as 1/n²',
                  ),
                ],
              ),
              
              // Parseval's Theorem
              CheatSheetSection(
                title: 'Parseval\'s Theorem',
                children: [
                  FormulaCard(
                    title: 'Energy Relation',
                    formula: r'\frac{1}{T}\int_{0}^{T}|f(t)|^2 dt = |a_0|^2 + \frac{1}{2}\sum_{n=1}^{\infty}(|a_n|^2 + |b_n|^2)',
                    details: [
                      'Relates signal energy in time domain to energy in frequency domain',
                      'Useful for power calculations in signals',
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// A section in the cheat sheet with a title and content
class CheatSheetSection extends StatelessWidget {
  final String title;
  final String? content;
  final List<Widget> children;

  const CheatSheetSection({
    super.key,
    required this.title,
    this.content,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue.shade700,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        
        // Optional content text
        if (content != null)
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Text(
              content!,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        
        // Child widgets
        ...children,
        
        const SizedBox(height: 10),
      ],
    );
  }
}

// Card displaying a formula with title and details
class FormulaCard extends StatelessWidget {
  final String title;
  final String formula;
  final List<String> details;

  const FormulaCard({
    super.key,
    required this.title,
    required this.formula,
    this.details = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.blue.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            
            // Main formula
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Math.tex(
                  formula,
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            
            // Details/coefficients
            if (details.isNotEmpty) ...[
              const Divider(),
              const Text('Where:', style: TextStyle(fontStyle: FontStyle.italic)),
              const SizedBox(height: 4),
              ...details.map((detail) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Math.tex(
                  detail,
                  textStyle: const TextStyle(fontSize: 14),
                ),
              )),
            ],
          ],
        ),
      ),
    );
  }
}

// Card for displaying properties and operations
class PropertyCard extends StatelessWidget {
  final String title;
  final String content;
  final String? formula;
  final String? extraInfo;

  const PropertyCard({
    super.key,
    required this.title,
    required this.content,
    this.formula,
    this.extraInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.blue.shade100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(content),
            ),
            
            // Optional formula
            if (formula != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Math.tex(
                    formula!,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              
            // Optional extra information
            if (extraInfo != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  extraInfo!,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Card for displaying common waveforms
class WaveFormCard extends StatelessWidget {
  final String title;
  final String formula;
  final String notes;

  const WaveFormCard({
    super.key,
    required this.title,
    required this.formula,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.green.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            
            // Formula
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Math.tex(
                  formula,
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            
            // Notes
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                notes,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }
}