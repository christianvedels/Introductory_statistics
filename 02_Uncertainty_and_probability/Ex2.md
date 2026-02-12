# Warm-up worked example: Sample space depends on what is recorded (new experiment)

---

## Setup
Draw one card from a standard 52-card deck.

Sample space: all 52 cards

Define events:
- $A$ = "card is red"
- $B$ = "card is a face card (J, Q, K)"

Tasks:
1. Describe $A$ and $B$ in words and with counts  
2. Find $A \cap B$, $A \cup B$, and $A^c$  
3. Compute $P(A)$, $P(B)$, $P(A \cap B)$, $P(A \cup B)$

---

## Worked solution
### Step 1 — counts
- Red cards: 26 $\Rightarrow P(A)=26/52=1/2$
- Face cards: 12 $\Rightarrow P(B)=12/52=3/13$

### Step 2 — intersection ($A \cap B$)
Red face cards: hearts + diamonds each have J,Q,K → $3+3=6$  
So: $|A\cap B|=6 \Rightarrow P(A\cap B)=6/52=3/26$

### Step 3 — union ($A \cup B$)
Use addition rule:
$P(A\cup B)=P(A)+P(B)-P(A\cap B)$

Compute:
$P(A\cup B)=\frac{26}{52}+\frac{12}{52}-\frac{6}{52}=\frac{32}{52}=\frac{8}{13}$

### Step 4 — complement
$A^c$ = “card is black”  
$P(A^c)=1-P(A)=1-1/2=1/2$

---

## Key takeaway (underline)
Intersection = “and”, union = “or”, complement = “not” — and counting makes probabilities easy.