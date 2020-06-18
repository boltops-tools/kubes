class Pager
  def self.setup
    new.setup
  end

  def initialize
    @sidebar = Element.find("#sidebar")
  end

  def setup
    on_left_right
    add_page_buttons
    on_prev_next
  end

  # When left and right clicked, go to next page based on the sidebar
  def on_left_right
    Document.on("keyup") do |e|
      case e.which
      when 37 # left
        goto_link("prev")
      when 39 # right
        goto_link("next")
      else
        # puts "something else pressed #{e.which}"
      end
    end
  end

  def add_page_buttons
    return unless Element.find("#sidebar").size > 0

    html =<<~EOL
      <div class="prev-next-buttons">
        <a id="prev" class="btn btn-basic">Back</a>
        <a id="next" class="btn btn-primary">Next Step</a>
        <p class="keyboard-tip">Pro tip: Use the <- and -> arrow keys to move back and forward.</p>
      </div>
    EOL

    fluid = Element.find(".container-fluid")
    fluid.append(html)
  end

  def on_prev_next
    next_link = Element.find("#next")
    next_link.on('click') do |e|
      goto_link("next")
    end
    prev_link = Element.find("#prev")
    prev_link.on('click') do |e|
      goto_link("prev")
    end
  end

  def goto_link(direction)
    links = sidebar_links
    current_link = find_current
    current_index = links.index(current_link)

    link = if direction == "next"
             last = current_index == links.size - 1
             i = last ? 0 : current_index + 1
             links.at(i)
           else # prev
             i = current_index-1
             links.at(i)
           end

    if link
      href = link.attr("href")
      $window.location.assign(href)
    end
  end

  @@sidebar_links = nil
  def sidebar_links
    return @@sidebar_links if @@sidebar_links
    @@sidebar_links = @sidebar.find(".content-nav a")
  end

  def find_current
    current_location = $window.location.path # `window.location.pathname`

    links = sidebar_links
    links.select do |l|
      l.attr("href") == current_location
    end.first
  end
end
