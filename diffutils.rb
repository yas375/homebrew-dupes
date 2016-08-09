class Diffutils < Formula
  desc "File comparison utilities"
  homepage "https://www.gnu.org/s/diffutils/"
  url "https://ftpmirror.gnu.org/diffutils/diffutils-3.4.tar.xz"
  mirror "https://ftp.gnu.org/gnu/diffutils/diffutils-3.4.tar.xz"
  sha256 "db53c025f2ac3d217bcf753dad6dee7b410b33d0948495ff015aaf8b91189ce2"

  bottle do
    cellar :any_skip_relocation
    sha256 "f2854483f252507a394909a5b195a0e7d5465e46ba3ff7716c8c48875f7c507d" => :el_capitan
    sha256 "49cf30eb22d24060e958f8a28d7d4321346026d09a49deca9ad018e995b5a428" => :yosemite
    sha256 "f7a85774a084e5b06f0c62d203dae04336973c79d4009245cd33025bf22aecbf" => :mavericks
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
