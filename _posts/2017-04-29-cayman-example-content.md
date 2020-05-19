---
layout: post
title: "The Metropolis-Hastings algorithm"
---

The Metropolis-Hastings algorithm is an algorithm that **samples from a probability density function** p from which direct sampling is difficult.

##### [](#header-4)Steps

1.  Start by choosing a point x somewhere in space.
2.  Let the point jump to a different location x', using a symmetric jumping distribution (for instance a Gaussian). Such a jumping process is called **Monte Carlo Markov chain**. 
3.  Accept x' as one of the sampled points with the probability min(1, p(x’)/p(x)).
4.  If x' is rejected, try the jumping again. Else perform the next jump from x'.

##### [](#header-4)Applications

##### [](#header-5)Simulated annealing

In simulated annealing the p is a Laplacian of the objective function E(x).
    p(x) = exp(-E(x)/kBT)).
•	the jumping function is a Gaussian j(Δx) = (2*pi*T)^(n_dims/2) * exp(Δx^2/(2T))
•	The temperature is decreased, such that the pdf and the jumping function become slimmer and slimmer.
Note the following: If E(x) is the negative log-likelihood/posterior and the finial kBT is one, then simulated annealing samples from the likelihood/posterior function. But, I think the purpose of simulated annealing is not to sample from a pdf, but rather find its maximum. I.e., the final k-BT is close to zero.

Parallel Tempering
In parallel tempering
•	The acceptance rate is min(1, e-ΔE(x)/k_bT)
•	Multiple MCMCs of different temperatures T are run in parallel
•	Every now and then chains in decreasing temperature order exchange parameters with a probability of min(1, eΔβΔE)





Text can be **bold**, _italic_, or ~~strikethrough~~.

[Link to another page: About]({{ '/about.html' | absolute_url }}).

There should be whitespace between paragraphs.

There should be whitespace between paragraphs. We recommend including a README, or a file with information about your project.

# [](#header-1)Header 1

This is a normal paragraph following a header. GitHub is a code hosting platform for version control and collaboration. It lets you and others work together on projects from anywhere.

## [](#header-2)Header 2

> This is a blockquote following a header.
>
> When something is important enough, you do it even if the odds are not in your favor.

### [](#header-3)Header 3

```js
// Javascript code with syntax highlighting.
var fun = function lang(l) {
  dateformat.i18n = require('./lang/' + l)
  return true;
}
```

```ruby
# Ruby code with syntax highlighting
GitHubPages::Dependencies.gems.each do |gem, version|
  s.add_dependency(gem, "= #{version}")
end
```

#### [](#header-4)Header 4

*   This is an unordered list following a header.
*   This is an unordered list following a header.
*   This is an unordered list following a header.

##### [](#header-5)Header 5

1.  This is an ordered list following a header.
2.  This is an ordered list following a header.
3.  This is an ordered list following a header.

###### [](#header-6)Header 6

| head1        | head two          | three |
|:-------------|:------------------|:------|
| ok           | good swedish fish | nice  |
| out of stock | good and plenty   | nice  |
| ok           | good `oreos`      | hmm   |
| ok           | good `zoute` drop | yumm  |

### There's a horizontal rule below this.

* * *

### Here is an unordered list:

*   Item foo
*   Item bar
*   Item baz
*   Item zip

### And an ordered list:

1.  Item one
1.  Item two
1.  Item three
1.  Item four

### And a nested list:

- level 1 item
  - level 2 item
  - level 2 item
    - level 3 item
    - level 3 item
- level 1 item
  - level 2 item
  - level 2 item
  - level 2 item
- level 1 item
  - level 2 item
  - level 2 item
- level 1 item

### Small image

![Octocat](https://github.githubassets.com/images/icons/emoji/octocat.png)

### Large image

![Branching](https://guides.github.com/activities/hello-world/branching.png)


### Definition lists can be used with HTML syntax.

<dl>
<dt>Name</dt>
<dd>Godzilla</dd>
<dt>Born</dt>
<dd>1952</dd>
<dt>Birthplace</dt>
<dd>Japan</dd>
<dt>Color</dt>
<dd>Green</dd>
</dl>

```
Long, single-line code blocks should not wrap. They should horizontally scroll if they are too long. This line should be long enough to demonstrate this.
```

```
The final element.
```
