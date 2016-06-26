# "File" is a reserved class name
class FileFormula < Formula
  desc "Utility to determine file types"
  homepage "https://www.darwinsys.com/file/"
  url "ftp://ftp.astron.com/pub/file/file-5.28.tar.gz"
  mirror "https://fossies.org/linux/misc/file-5.28.tar.gz"
  sha256 "0ecb5e146b8655d1fa84159a847ee619fc102575205a0ff9c6cc60fc5ee2e012"

  head "https://github.com/file/file.git"

  bottle do
    cellar :any
    revision 1
    sha256 "17cb380bfdf672e4cad9a324f1e81f7cc72d2f390cc8a732046f976b21362641" => :el_capitan
    sha256 "3116d7d15a6ca96347b53af0c28773f5d7a35b41de8f7451f9c23ef1196b7dda" => :yosemite
    sha256 "cace05a8a01b3a64b7e4c0d848b5abf69395750f63169fdd7eb460b4944f3556" => :mavericks
  end

  keg_only :provided_by_osx

  depends_on "libmagic"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install-exec"
    system "make", "-C", "doc", "install-man1"
    rm_r lib
  end

  test do
    system "#{bin}/file", test_fixtures("test.mp3")
  end
end
