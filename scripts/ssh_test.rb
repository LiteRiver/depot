require 'sshkit'
require 'sshkit/dsl'

include SSHKit::DSL

def mkdir
  on 'wellread8', in: :sequence do |_host|
    puts 'Now mkdir for user `clive`'

    as('root') do
      puts capture(:whoami)
      execute(:su, '- clive -lc "mkdir sshkit-test"')
    end
  end
end

mkdir
