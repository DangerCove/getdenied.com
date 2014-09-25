---
layout: page
title: News &amp; Updates
description: News and updates about Denied for Mac and other music related articles.
---

<ol class="posts">
  {% for post in site.posts %}
    <li>
      <article>
        <header>
          <span class="date">{{ post.date | date_to_long_string }}</span>
          <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
        </header>
        <div class="excerpt">
          {{ post.excerpt }}
          {% if post.content != post.excerpt %}
            <a class="btn" href="{{ post.url }}">Read on &rarr;</a>
          {% endif %}
        </div>
      </article>
    </li>
  {% endfor %}
</ol>