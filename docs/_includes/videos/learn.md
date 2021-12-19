<div class="learn">
  <a href="https://learn.boltops.com/courses/{{ include.url }}">
    {% if include.img %}
    <img src="{{ include.img }}" />
    {% else %}
    <img src="https://learn.boltops.com/courses/{{ include.url }}/thumbnail.png" />
    {% endif %}
  </a>
  {% unless include.premium == false %}
  <div class="note">Note: Premium video content requires a subscription.</div>
  {% endunless %}
</div>
