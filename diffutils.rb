class Diffutils < Formula
  desc "File comparison utilities"
  homepage "https://www.gnu.org/s/diffutils/"
  url "https://ftpmirror.gnu.org/diffutils/diffutils-3.5.tar.xz"
  mirror "https://ftp.gnu.org/gnu/diffutils/diffutils-3.5.tar.xz"
  sha256 "dad398ccd5b9faca6b0ab219a036453f62a602a56203ac659b43e889bec35533"

  bottle do
    cellar :any_skip_relocation
    sha256 "d7e91145143946fb73d0e5be09d2f08915bd7f1164e34b985fd935fe166e69c9" => :el_capitan
    sha256 "08eed20300717842d35896a3a552b1cbbd3822d2bfdf5e6ca6ca05d526d4782a" => :yosemite
    sha256 "528fbc3f85e46916d7bc5ce2e3a5e2bebaf18fcccc9bd035798c7fdea441f0e0" => :mavericks
  end

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"a").write "foo"
    (testpath/"b").write "foo"
    system bin/"diff", "a", "b"
  end
end
