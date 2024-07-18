class Nfsmount < Formula
  desc "NFS mount service for specific share"
  homepage "https://github.com/LucienBrule/homebrew-local"
  url "https://github.com/LucienBrule/homebrew-local/archive/v1.0.0.tar.gz"
  sha256 "the_actual_sha256_of_your_tarball"
  license "MIT"

  def install
    bin.install "scripts/mount_nfs.sh"
  end

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{bin}/mount_nfs.sh</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <false/>
      </dict>
      </plist>
    EOS
  end

  test do
    system "#{bin}/mount_nfs.sh", "--version"
  end
end
