########################################################################################################################
#!!
#! @description: Disables a computer account in Active Directory.
#!
#! @input host: The domain controller to connect to.
#! @input distinguished_name: The Organizational Unit DN or Common Name DN to add the computer to.
#!                            Example: OU=OUTest1,DC=battleground,DC=ad.
#! @input computer_common_name: The name of the computer (its CN).
#! @input username: The user to connect to Active Directory as.
#!                  Optional
#! @input password: The password of the user to connect to Active Directory.
#!                  Optional
#! @input protocol: The protocol to use when connecting to the Active Directory server.
#!                  Valid values: 'HTTP' and 'HTTPS'.
#!                  Optional
#! @input trust_all_roots: Specifies whether to enable weak security over SSL. A SSL certificate is trust even if no
#!                         trusted certification authority issued it.
#!                         Valid values: true, false.
#!                         Default value: true
#!                         Optional
#! @input trust_keystore: The location of the TrustStore file.
#!                        Example: %JAVA_HOME%/jre/lib/security/cacerts.
#!                        Optional
#! @input trust_password: The password associated with the TrustStore file.
#!                        Optional
#! @input connection_timeout: Time in milliseconds to wait for the connection to be made.
#!                            Default value: 10000.
#!                            Optional
#! @input execution_timeout: Time in milliseconds to wait for the connection to complete.
#!                           Default value: 90000.
#!                           Optional
#!
#! @output return_result: The return result of the operation.
#! @output computer_distinguished_name: The distinguished name of the computer account that was disabled.
#! @output return_code: The return code of the operation. 0 if the operation succeeded, -1 if the operation fails.
#! @output exception: The exception message if the operation fails.
#!
#! @result SUCCESS: The computer account was disabled successfully.
#! @result FAILURE: Failed to disable the computer account.
#!!#
########################################################################################################################

namespace: io.cloudslang.base.ldap.computers

operation: 
  name: disable_computer_account
  
  inputs: 
    - host    
    - distinguished_name    
    - distinguishedName: 
        default: ${get('distinguished_name', '')}  
        required: false 
        private: true 
    - computer_common_name    
    - computerCommonName: 
        default: ${get('computer_common_name', '')}  
        required: false 
        private: true 
    - username:
        required: false  
    - password:  
        required: false  
        sensitive: true
    - protocol:  
        required: false  
    - trust_all_roots:
        default: 'true'
        required: false  
    - trustAllRoots: 
        default: ${get('trust_all_roots', '')}  
        required: false 
        private: true 
    - trust_keystore:  
        required: false  
    - trustKeystore: 
        default: ${get('trust_keystore', '')}  
        required: false 
        private: true 
    - trust_password:  
        required: false  
        sensitive: true
    - trustPassword: 
        default: ${get('trust_password', '')}  
        required: false 
        private: true 
        sensitive: true
    - connection_timeout:
        default: '10000'
        required: false  
    - connectionTimeout: 
        default: ${get('connection_timeout', '')}  
        required: false 
        private: true 
    - execution_timeout:
        default: '90000'
        required: false  
    - executionTimeout: 
        default: ${get('execution_timeout', '')}  
        required: false 
        private: true 
    
  java_action: 
    gav: 'io.cloudslang.content:cs-ldap:0.0.1-RC3'
    class_name: 'io.cloudslang.content.ldap.actions.computers.DisableComputerAccountAction'
    method_name: 'execute'
  
  outputs: 
    - return_result: ${get('returnResult', '')} 
    - computer_distinguished_name: ${get('computerDistinguishedName', '')} 
    - return_code: ${get('returnCode', '')} 
    - exception: ${get('exception', '')} 
  
  results: 
    - SUCCESS: ${returnCode=='0'} 
    - FAILURE
