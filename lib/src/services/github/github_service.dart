class GitHubService {
  String convertUrl(String originalUrl, String githubPersonalAccessToken) {
    if (!originalUrl.startsWith('https://github.com/')) {
      throw ArgumentError('Invalid GitHub URL');
    }

    final repoPart =
        "${originalUrl.substring("https://github.com/".length)}.git";

    return 'https://x-access-token:$githubPersonalAccessToken@github.com/$repoPart';
  }
}
