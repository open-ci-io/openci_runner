const certificateDirectory = '~/Downloads/certificates';
const keychainPath = '$certificateDirectory/app-signing.keychain-db';
const p12 = '$certificateDirectory/build_certificate.p12';
const mobileprovisionPath = '$certificateDirectory/build_pp.mobileprovision';
const keychainPassword = 'password';

String ipaBuildPath(String appName) =>
    '/Users/admin/Downloads/$appName/build/ios/ipa/$appName.ipa';
