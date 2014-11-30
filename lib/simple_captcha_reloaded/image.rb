require 'open3'
module SimpleCaptchaReloaded
  class Image
    IMAGE_STYLES = {
      'embosed_silver'  => ['-fill darkblue', '-shade 20x60', '-background white'],
      'simply_red'      => ['-fill darkred', '-background white'],
      'simply_green'    => ['-fill darkgreen', '-background white'],
      'simply_blue'     => ['-fill darkblue', '-background white'],
      'distorted_black' => ['-fill darkblue', '-edge 10', '-background white'],
      'all_black'       => ['-fill darkblue', '-edge 2', '-background white'],
      'charcoal_grey'   => ['-fill darkblue', '-charcoal 5', '-background white'],
      'almost_invisible' => ['-fill red', '-solarize 50', '-background white']
    }

    DISTORTIONS = {
      low:    -> { [0 + rand(2), 80 + rand(20)] },
      medium: -> { [2 + rand(2), 50 + rand(20)] },
      high:   -> { [4 + rand(2), 30 + rand(20)] },
    }
    IMPLODES = {
      none:    0,
      low:     0.1,
      medium:  0.2,
      high:    0.3
    }

    def initialize(implode: :medium,
                   distortion: :random,
                   image_styles: IMAGE_STYLES,
                   noise: 0,
                   size: '100x28',
                   image_magick_path: '',
                   tmp_path: nil)
      @implode           = implode
      @distortion        = distortion
      if !DISTORTIONS.keys.include?(@distortion)
        @distortion = DISTORTIONS.keys.sample
      end
      @distortion_function = DISTORTIONS[@distortion]
      @image_styles      = image_styles
      @noise             = noise
      @size              = size
      @image_magick_path = image_magick_path
      @tmp_path          = tmp_path
    end

    def generate(text)
      amplitude, frequency = calculate_distortion

      params = image_params
      params << "-size #{@size}"
      params << "-wave #{amplitude}x#{frequency}"
      params << "-gravity Center"
      params << "-pointsize 22"
      params << "-implode #{IMPLODES[@implode]}"
      params << "label:#{text}"
      params << "-evaluate Uniform-noise #{@noise}"
      params << "jpeg:-"
      run("convert", params.join(' '))
    end

    protected

    def image_params
      @image_styles.values.sample
    end

    def calculate_distortion
      @distortion_function.call()
    end

    def run(cmd, params = "")
      command = %Q[#{cmd} #{params}].gsub(/\s+/, " ")
      command = "#{command} 2>&1"
      unless (image_magick_path = @image_magick_path).blank?
        command = File.join(image_magick_path, command)
      end
      stderr_r, stderr_w = IO.pipe
      stdout_r, stdout_w = IO.pipe
      success = system(command, out: stdout_w, err: stderr_w)
      stdout_w.close; stderr_w.close
      output = stdout_r.read
      error = stderr_r.read
      unless success
        raise ::StandardError, "Error while running #{command}\n Exit Code: #{$?}\n stderr:#{error.inspect}\n stdout:#{output.inspect}"
      end
      output
    end
  end
end
