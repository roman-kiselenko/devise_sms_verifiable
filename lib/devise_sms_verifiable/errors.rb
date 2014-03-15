class DeviseSmsVerifiableError < RuntimeError;end
class UnauthorizedAccess < DeviseSmsVerifiableError;end
class ConfirmationMethodNotFound < DeviseSmsVerifiableError;end
class SecretMethodNotFound < DeviseSmsVerifiableError;end
class PhoneFieldNotFound < DeviseSmsVerifiableError;end
class PhoneFieldEmpty < DeviseSmsVerifiableError;end
class ValidSendSmsMethodNotFound < DeviseSmsVerifiableError;end

