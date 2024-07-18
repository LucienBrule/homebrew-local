class Nfsmount < Formula
  desc "NFS mount service for specific share"
  homepage "https://github.com/LucienBrule/homebrew-local"
  url "https://github.com/LucienBrule/homebrew-local/archive/refs/tags/v1.0.5.tar.gz"
  sha256 "cdf081b8e3bc3f74cefc18b295977079a975c4b4bd64516b36f1423820f42c49"
  license "MIT"

  def install
    bin.install "scripts/mount_nfs.sh"
  end

  service do
    run ["/bin/bash", opt_bin/"mount_nfs.sh"]
    keep_alive true
    run_at_load true
    log_path "/tmp/nfsmount.log"
    error_log_path "/tmp/nfsmount.error.log"
    working_dir HOMEBREW_PREFIX
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
          <string>/bin/bash</string>
          <string>#{opt_bin}/mount_nfs.sh</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{HOMEBREW_PREFIX}</string>
        <key>StandardOutPath</key>
        <string>/tmp/nfsmount.log</string>
        <key>StandardErrorPath</key>
        <string>/tmp/nfsmount.error.log</string>
      </dict>
      </plist>
    EOS
  end

  test do
    system "#{bin}/mount_nfs.sh", "--version"
  end
end
