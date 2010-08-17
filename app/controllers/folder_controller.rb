class FolderController < ApplicationController

  include Blacklight::SolrHelper

  # fetch the documents that match the ids in the folder
  def index
    @documents = get_solr_response_for_doc_ids(session[:folder_document_ids] || [])
  end

  # add a document_id to the folder
  def create
    session[:folder_document_ids] = session[:folder_document_ids] || []
    session[:folder_document_ids] << params[:id] 
    flash[:notice] = "Item successfully added to Folder"
    redirect_to :back
  end
 
  # remove a document_id from the folder
  def destroy
    session[:folder_document_ids].delete(params[:id])
    flash[:notice] = "Item successfully removed from Folder"
    redirect_to folder_index_path
  end
 
  # get rid of the items in the folder
  def clear
    flash[:notice] = "Cleared Folder"
    session[:folder_document_ids] = []
    redirect_to folder_index_path
  end
 
end