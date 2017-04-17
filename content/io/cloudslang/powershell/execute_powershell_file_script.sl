#   (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
####################################################
# Executes PowerShell script from a local file on a given remote host.
#
# Inputs:
#   - host - the hostname or IP address of the PowerShell host
#   - username - the username to use when connecting to the server
#   - password - The password to use when connecting to the server
#   - path_to_script - path to the script to execute on the PowerShell host
# Outputs:
#   - return_result - output of the powershell script
#   - status_code - status code of the execution
#   - error_message - operation error message
####################################################
namespace: io.cloudslang.powershell

operation:
  name: execute_powershell_file_script
  inputs:
    - host
    - username
    - password
    - path_to_script
  action:
    python_script: |
      import winrm
      try:
          s = winrm.Session(host, auth=(username, password))
          with open(path_to_script) as f:
              str = f.read()
              r = s.run_ps(str)
              return_result = r.std_out
              status_code = r.status_code
              error_message = r.std_err
      except IOError as e:
          error_message = "I/O error({0}): {1}".format(e.errno, e.strerror)
      except Exception as err:
          error_message = "Error: {0}".format(err)
  outputs:
    - return_result
    - status_code
    - error_message