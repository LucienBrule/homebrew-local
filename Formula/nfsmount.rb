class Nfsmount < Formula
  desc "NFS mount service for specific share"
  homepage "https://github.com/LucienBrule/homebrew-local"
  url "https://github.com/LucienBrule/homebrew-local/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "6bab4f893d712e3bf257b0b52b8be2d568c5ec6e0c8869e9c177e6223cec9d5d"
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
