class Make < Formula
  desc "Utility for directing compilation"
  homepage "https://www.gnu.org/software/make/"
  url "https://ftpmirror.gnu.org/make/make-4.2.1.tar.bz2"
  mirror "https://ftp.gnu.org/gnu/make/make-4.2.1.tar.bz2"
  sha256 "d6e262bf3601b42d2b1e4ef8310029e1dcf20083c5446b4b7aa67081fdffc589"

  bottle do
    sha256 "e6f872ec47d2157a7d5ae3f6854128844f8e305fb7ee54dd98c23fa7c4bc1561" => :el_capitan
    sha256 "c5cc8218cc2f379bdb8f5c5fb3847ac4a952f952cd6169b232f68d2cd99527f5" => :yosemite
    sha256 "04dd0b10205bce4ed7e0c58fea3363a72fe7116346fa0ae7fe7fa4116832f60a" => :mavericks
  end

  option "with-default-names", "Do not prepend 'g' to the binary"

  depends_on "guile" => :optional

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]

    args << "--with-guile" if build.with? "guile"
    args << "--program-prefix=g" if build.without? "default-names"

    system "./configure", *args
    system "make", "install"
  end

  test do
    (testpath/"Makefile").write <<-EOS.undent
      default:
      \t@echo Homebrew
    EOS

    cmd = build.with?("default-names") ? "make" : "gmake"

    assert_equal "Homebrew\n",
      shell_output("#{bin}/#{cmd}")
  end
end
