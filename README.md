# Computational Neuroscience Course

This repository supports an ongoing effort to build a systems and computational neuroscience course for USTC students. The goal is a two-semester sequence: the first semester covers foundational material, and the second introduces more advanced topics for undergraduate and graduate students.

| | |
|---|---|
| **When** | Monday 2:00 pm – 3:35 pm, Spring 2026 |
| **Where** | 高新区 G3-110 |
| **Teacher** | 温泉 &lt;qwen@ustc.edu.cn&gt; |
| **TA** |胡博洲 &lt;hubozhou@mail.ustc.edu.cn&gt; |
## Grading

| Component | Weight |
|---|---|
| Homework | 70% |
| Final exam (take-home) | 30% |

## Prerequisites

- High school knowledge of biology and neuroscience
- Proficiency in Python, MATLAB, or Julia
- Working knowledge of multivariate calculus, probability theory, linear algebra, and differential equations

## Recommended Textbooks

**Core**
- [Theoretical Neuroscience: Computational and Mathematical Modeling the Neural System](https://mitpress.ublish.com/book/theoretical-neuroscience)
- [Principles of Neural Design](https://direct.mit.edu/books/monograph/3078/Principles-of-Neural-Design)
- [Principles of Neurobiology](https://www.routledge.com/Principles-of-Neurobiology/Luo/p/book/9780815346050)
- [Theoretical Neuroscience: Understanding Cognition](https://www.taylorfrancis.com/books/mono/10.1201/9781003459361/theoretical-neuroscience-xiao-jing-wang)

**General audience**
- [Models of the Mind](https://www.amazon.com/Models-Mind-Engineering-Mathematics-Understanding/dp/1472966422)

## Course Overview

The emergence of intelligence and behavior from the complex interactions within the brain remains one of the most significant unsolved mysteries in modern science. In the last decade, rapid advancements in experimental tools have enabled us to monitor and manipulate brain circuits with unprecedented precision. Yet neuroscientists are still navigating the intricate landscapes of brain structures and dynamics. Mathematical theory has become essential for integrating seemingly unrelated evidence, generating new insights, guiding experiments, and identifying organizing principles of brain function.

This course explores how physics, engineering, and mathematics have shaped our understanding of the brain — in particular, the relationship between structure, dynamics, representation, and behavior. A central theme is comparing biological learning rules and architectures with modern machine learning methods. Special topics may include wiring optimization in neural circuits, attractor and chaotic dynamics in neural networks, sensory and motor representations, biological learning rules, Hopfield networks, and hierarchical control of behavior.

## Spring 2026 Curriculum

The course consists of 8 lectures (~90 minutes each). In this semester, we will explore the connections between Natural and Artificial Intelligence. 

### 1. Computing Architectures: From Neurons to Nodes
- Biophysics of real neurons and dendritic integration vs. artificial activation functions
- Energy efficiency and parallel processing across biological and GPU architectures

### 2. Neural Code Representations & Network Dynamics
- Information encoding (rate vs. temporal coding) and population vectors
- Network dynamics and neural manifolds; random matrix theory and stability in RNNs

### 3. Learning Rules I: The Credit Assignment Problem
- Biological plasticity (Hebbian learning and STDP) vs. gradient descent and backpropagation
- Biological approximations of backprop (e.g., predictive coding)

### 4. Learning Rules II: Reward and Reinforcement
- The dopamine system and reward prediction errors in the basal ganglia
- Temporal difference (TD) learning and Q-learning mapped to biological pathways

### 5. Sensory Processing and Perception
- Visual hierarchies (retina to IT cortex) vs. convolutional neural networks (CNNs)
- Object recognition invariances and robustness in natural vs. artificial vision

### 6. Memory, Space, and Continuous Learning
- The hippocampal–entorhinal system: place cells, grid cells, and systems consolidation
- Catastrophic forgetting in AI and solutions via experience replay and complementary learning systems

### 7. Motor Control and Embodied AI
- Motor subspace dynamics and hierarchical control of behavior
- Sensorimotor integration in model organisms (C. elegans, larval zebrafish) and implications for robotic control

### 8. Future Frontiers: Generalization and Cognitive Architecture
- Few-shot learning and unsupervised learning gaps
- Evaluating modern architectures (Transformers/LLMs) against known biological cognitive structures

## Repository Structure

```
.
├── Books/            # Reading list and book resources
├── Homework/         # Problem sets and final exam
├── Just_For_Fun/     # Optional explorations and demos
├── Notes_of_Teacher/ # Lecture notes
├── Papers/           # Assigned and supplementary papers
└── Slides/           # Lecture slides
```
