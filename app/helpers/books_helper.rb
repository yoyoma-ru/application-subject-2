module BooksHelper
	def button_text
    if action_name == "edit"
      "Update Book"
    else action_name != "edit"
      "Create Book"
    end
    end
end
