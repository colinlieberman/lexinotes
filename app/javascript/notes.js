window.Notes = {
  updateNotes: function(jqXHR, statusText, formData) {
    if(statusText == 'error') {
      const { status, statusText, responseText } = jqXHR;
      alert(`Error: ${status} ${statusText}\n${responseText}`);
      return;
    }

    const {id, citations, content, tags, study_date, notebook_number, notebook_page} = jqXHR.responseJSON;

    this.tbody.prepend(`<tr data-id="${id}"><td>${study_date}</td><td>${citations}</td><td>${content}</td>
                        <td>${tags}</td><td>${notebook_number || ''}</td><td>${notebook_page || ''}</td></tr>`);

    this.closeModal();
  },

  closeModal: function() {
    this.noteModal.hide();
    this.noteModal.find('input,textarea').val(function() {
      if(this.type == 'submit') {
        return this.value;
      }
      else {
        return '';
      }
    });
    this.noteModal.find('input,textarea').data('value', '');
  },

  initAddNoteButtons: function() {
    const that = this;
    this.addNoteButtons.on('click', function() {
      that.noteModal.show();
    })
  },


  initNoteModal: function() {
    // TODO: require all book/chapter/verse if any set
    const that = this;
    this.modalCancelButton.on('click', function(e) {
      e.preventDefault();
      that.closeModal();
    });
  },

  init: function() {
    this.notes = $('#notes tbody tr');
    this.noteModal = $('#note-modal');
    this.addNoteButtons = $('.add-note');
    this.modalCancelButton = this.noteModal.find('button.cancel');

    this.tbody = $('#notes tbody');

    this.initAddNoteButtons();
    this.initNoteModal();
  }
};

$(document).ready(function() {
  Notes.init();
});
