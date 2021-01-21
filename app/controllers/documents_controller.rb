class DocumentsController < ApplicationController

  def new
    @document = Document.new
    @documents = Document.all
  end

  def create
    @document = Document.new(document_params)
    @document.signed_on = DateTime.now

    if @document.save
      redirect_to root_url, notice: 'Signature Saved'
    else
      render :new
    end
  end

  def add_sign_to_pdf
    dataURL = Document.find(params[:id]).signature
    start = dataURL.index(',') + 1                   # .index used here
    x = Base64.decode64 dataURL[start..-1]
    File.open("#{Rails.root}/tmp/test1.png",'wb') {|file| file.write x}

    doc = HexaPDF::Document.open("#{Rails.root}/tmp/sample-pdf-file.pdf")
    page = doc.pages[0]
    canvas = page.canvas(type: :overlay)
    canvas.translate(0, 20) do
      canvas.line_width(0.5)
      canvas.opacity(fill_alpha: 1, stroke_alpha: 1) do
        canvas.image("#{Rails.root}/tmp/test1.png", at: [400, 400], height: 80)
      end
    end
    doc.write("#{Rails.root}/tmp/signed_doc.pdf", optimize: true)
    redirect_to signed_document_documents_path
  end

  def document_to_be_signed; end

  def signed_document
    pdf_filename = File.join(Rails.root, "tmp/signed_doc.pdf")
    send_file(pdf_filename, :filename => "signed_doc.pdf", :type => "application/pdf", :disposition => 'inline')
  end



  private

  def document_params
    params.require(:document).permit(:signature)
  end
end