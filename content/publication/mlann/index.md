---
title: "Computationally Efficient Learning of Statistical Manifolds"
authors:
- admin
- Anastasios Panagiotelis
- Rob J Hyndman
date: "2021-02-22"
doi: ""

# Schedule page publish date (NOT publication's date).
# publishDate: "2021-01-10T00:00:00Z"

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ""

# Publication name and optional abbreviated publication name.
publication: ""
publication_short: ""

abstract: Analyzing high-dimensional data with manifold learning algorithms often requires searching for the nearest neighbors of all observations. This presents a computational bottleneck in statistical manifold learning when observations of probability distributions rather than vector-valued variables are available or when data size is large. We resolve this problem by proposing a new method for approximation in statistical manifold learning. The novelty of our approximation is the strongly consistent distance estimators based on independent and identically distributed samples from probability distributions. By exploiting the connection between Hellinger/total variation distance for discrete distributions and the L2/L1 norm, we demonstrate that the proposed distance estimators, combined with approximate nearest neighbor searching, could largely improve the computational efficiency with little to no loss in the accuracy of manifold embedding. The result is robust to different manifold learning algorithms and different approximate nearest neighbor algorithms. The proposed method is applied to learning statistical manifolds of electricity usage. This application demonstrates how underlying structures in high dimensional data, including anomalies, can be visualized and identified, in a way that is scalable to large datasets.

# Summary. An optional shortened abstract.
summary: []

featured: true

# links:
# - name: ""
#   url: ""
url_pdf: 'https://arxiv.org/pdf/2103.11773'
url_code: 'https://github.com/ffancheng/paper-mlann'
url_dataset: ''
url_poster: ''
url_project: ''
url_slides: ''
url_source: ''
url_video: ''

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Associated Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `internal-project` references `content/project/internal-project/index.md`.
#   Otherwise, set `projects: []`.
projects: []

# Slides (optional).
#   Associate this publication with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides: "example"` references `content/slides/example/index.md`.
#   Otherwise, set `slides: ""`.
slides: []
---
