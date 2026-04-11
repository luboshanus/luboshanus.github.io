---
layout: homepage
title: Random Posts
permalink: /posts/
---

<h1 class="page-title-spaced">Random Posts</h1>

These are random notes that depict interesting topics or stories in economics or econometrics.

{% if site.posts.size > 0 %}
<ul class="post-list">
  {% for post in site.posts %}
  <li>
    <a class="post-list-title" href="{{ post.url | relative_url }}">{{ post.title }}</a>
    <span class="post-meta">{{ post.date | date: "%B %-d, %Y" }}</span>
    {% if post.excerpt %}
    <p>{{ post.excerpt | strip_html | truncate: 180 }}</p>
    {% endif %}
  </li>
  {% endfor %}
</ul>
{% else %}
No posts yet.
{% endif %}
