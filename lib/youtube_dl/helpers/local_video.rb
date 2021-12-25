module LocalVideo
  # Safely run command with error checking and logging
  def run_command(command, description)
    Hanami.logger.info description

    stdin, stdout, stderr, wait_thr = Open3.popen3(command)
    exit_status = wait_thr.value
    lines_stdout = stdout.read
    lines_stderr = stderr.read

    if exit_status != 0
      Hanami.logger.error "Exit status: #{exit_status}"
      Hanami.logger.info "STDOUT: #{lines_stdout}"
      Hanami.logger.info "STDERR: #{lines_stderr}"
    end

    [lines_stdout.chomp, lines_stderr, exit_status]
  end
end