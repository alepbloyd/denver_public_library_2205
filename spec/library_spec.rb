require 'rspec'
require './lib/book'
require './lib/author'
require './lib/library'

RSpec.describe Library do

  before :each do
    @dpl = Library.new("Denver Public Library")

    @charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})

    @jane_eyre = @charlotte_bronte.write("Jane Eyre", "October 16, 1847")

    @professor = @charlotte_bronte.write("The Professor", "1857")

    @villette = @charlotte_bronte.write("Villette", "1853")

    @harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})

    @mockingbird = @harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
  end

  it 'exists' do
    expect(@dpl).to be_instance_of(Library)
  end

  it 'returns name' do
    expect(@dpl.name).to eq("Denver Public Library")
  end

  it 'initializes with empty array of books' do
    expect(@dpl.books).to be_instance_of(Array)
  end

  it 'initializes with empty array of authors' do
    expect(@dpl.authors).to be_instance_of(Array)
  end

  it 'can add authors' do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)

    expect(@dpl.authors).to be_instance_of(Array)
    expect(@dpl.authors.length).to eq(2)
  end

  it 'adds books by author' do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)

    expect(@dpl.books).to be_instance_of(Array)
    expect(@dpl.books.length).to eq(4)
  end

  it 'returns publication time frame for given author' do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)

    expect(@dpl.publication_time_frame_for(@charlotte_bronte)).to be_instance_of(Hash)

    expect(@dpl.publication_time_frame_for(@charlotte_bronte)).to eq({:start=>"1847", :end=>"1857"})

    expect(@dpl.publication_time_frame_for(@harper_lee)).to eq({:start=>"1960", :end=>"1960"})
  end

  it 'returns false on checkout if book does not exist in library' do
    expect(@dpl.checkout(@mockingbird)).to be false

    expect(@dpl.checkout(@jane_eyre)).to be false
  end

  it 'returns true on checkout if book exists in library' do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)

    expect(@dpl.checkout(@jane_eyre)).to be true
  end

  it 'returns array of checked out books' do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)

    @dpl.checkout(@jane_eyre)

    expect(@dpl.checked_out_books).to be_instance_of(Array)

    expect(@dpl.checked_out_books.length).to eq(1)
  end

  it 'returns false when checking out a book that is already checked out' do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)

    @dpl.checkout(@jane_eyre)

    expect(@dpl.checkout(@jane_eyre)).to be false
  end

  it 'can return a book' do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)

    @dpl.checkout(@jane_eyre)

    expect(@dpl.checked_out_books.length).to eq(1)

    @dpl.return(@jane_eyre)

    expect(@dpl.checked_out_books.length).to eq(0)
  end

  it 'returns most popular book' do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)

    @dpl.checkout(@jane_eyre)

    @dpl.return(@jane_eyre)

    @dpl.checkout(@jane_eyre)

    @dpl.checkout(@villette)

    @dpl.checkout(@mockingbird)

    @dpl.return(@mockingbird)

    @dpl.checkout(@mockingbird)

    @dpl.return(@mockingbird)

    @dpl.checkout(@mockingbird)

    expect(@dpl.most_popular_book.title).to eq("To Kill a Mockingbird")

  end

end
