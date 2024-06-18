module ApplicationHelper
  include Pagy::Frontend

  def prev_pagination_link(link_pagy, pagy)
    html = <<-HTML
        #{link_pagy.call(pagy.prev, '', 'aria-label="previous"').gsub('</a>', '')}
          <i class="fa-solid fa-arrow-left"></i>
        </a>
    HTML

    html.html_safe
  end

  def next_pagination_link(link_pagy, pagy)
    html = <<-HTML
        #{link_pagy.call(pagy.next, '', 'aria-label="previous"').gsub('</a>', '')}
          <i class="fa-solid fa-arrow-right"></i>
        </a>
    HTML

    html.html_safe
  end

  def get_borrow(book)
    current_user.borrows.find_by(book_id: book.id)
  end

  def borrow_book_class(borrow)
    borrow.overdue? ? "bg-red-500" : ""
  end
end
