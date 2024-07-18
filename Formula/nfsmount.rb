class Nfsmount < Formula
  desc "NFS mount service for specific share"
  homepage "https://github.com/LucienBrule/homebrew-local"
  url "https://github.com/LucienBrule/homebrew-local/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "c103a618bd374538d105727815a0f096e1dae3f70f048f6a13d12e79e3022472"
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
