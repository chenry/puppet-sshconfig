require 'formula'

class Sshpass < Formula
  #url 'http://sourceforge.net/projects/sshpass/files/sshpass/1.05/sshpass-1.05.tar.gz'
  url 'http://downloads.sourceforge.net/project/sshpass/sshpass/1.05/sshpass-1.05.tar.gz'
  #homepage 'http://sourceforge.net/projects/sshpass'
  homepage 'http://sshpass.sourceforge.net'
  md5 'c52d65fdee0712af6f77eb2b60974ac7'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end