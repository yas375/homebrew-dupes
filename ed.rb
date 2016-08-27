class Ed < Formula
  desc "Classic UNIX line editor"
  homepage "https://www.gnu.org/software/ed/ed.html"
  url "https://ftpmirror.gnu.org/ed/ed-1.13.tar.lz"
  mirror "https://ftp.gnu.org/gnu/ed/ed-1.13.tar.lz"
  sha256 "cd66c54a53cd6ef35a217556e7b2b2fdd973ca2708f4fc41636b0bc06388c7d3"

  bottle do
    cellar :any_skip_relocation
    sha256 "54c52be45bd1e33bcc50aab372e9ba3c2ef1cc7de5412b568710aa4ad1a55129" => :el_capitan
    sha256 "3992f9c431767907a9156ff007dd9431406dd384394d2da8fd48eb43b6baeb57" => :yosemite
    sha256 "10f5f317d4a6943c53b58fa937e9a14214a164b3cd764e2b747473b230b8a2a1" => :mavericks
  end

  deprecated_option "default-names" => "with-default-names"
  option "with-default-names", "Don't prepend 'g' to the binaries"

  def install
    ENV.j1

    args = ["--prefix=#{prefix}"]
    args << "--program-prefix=g" if build.without? "default-names"

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  def caveats
    if build.without? "default-names" then <<-EOS.undent
      The command has been installed with the prefix "g".
      If you do not want the prefix, reinstall using the "with-default-names" option.
      EOS
    end
  end

  test do
    testfile = testpath/"test"
    testfile.write "Hello world\n"
    cmd = build.with?("default-names") ? "ed" : "ged"
    pipe_output("#{bin}/#{cmd} -s #{testfile}", ",s/o//\nw\n", 0)
    assert_equal "Hell world\n", testfile.read
  end
end
