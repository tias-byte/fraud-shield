import 'package:http/http.dart' as http;

class URLValidatorService {
  // List of suspicious patterns and domains
  static const List<String> _suspiciousPatterns = [
    'bit.ly',
    'tinyurl.com',
    'short.link',
    't.co',
    'goo.gl',
    'ow.ly',
    'is.gd',
    'v.gd',
    'shorturl.at',
    'rebrand.ly',
    'cutt.ly',
    'short.link',
    'tiny.cc',
    'shorturl.com',
    'short.ly',
    'adf.ly',
    'shorte.st',
    'shorturl.at',
    'tinyurl.com',
    'bit.do',
    'shorturl.com',
    'short.ly',
    'shorturl.at',
    'tinyurl.com',
    'bit.ly',
    'tinyurl.com',
    'short.link',
    't.co',
    'goo.gl',
    'ow.ly',
    'is.gd',
    'v.gd',
    'shorturl.at',
    'rebrand.ly',
    'cutt.ly',
    'short.link',
    'tiny.cc',
    'shorturl.com',
    'short.ly',
    'adf.ly',
    'shorte.st',
    'shorturl.at',
    'tinyurl.com',
    'bit.do',
    'shorturl.com',
    'short.ly',
    'shorturl.at',
    'tinyurl.com',
  ];

  static const List<String> _suspiciousKeywords = [
    // Phishing and scam terms
    'phishing',
    'scam',
    'fraud',
    'malware',
    'virus',
    'hack',
    'steal',
    'stealing',
    'identity',
    'theft',
    'spoof',
    'fake',
    'clone',
    'imposter',
    
    // Financial and banking terms
    'password',
    'login',
    'bank',
    'banking',
    'paypal',
    'paypal-login',
    'amazon',
    'amazon-login',
    'apple',
    'apple-id',
    'google',
    'google-login',
    'facebook',
    'facebook-login',
    'instagram',
    'instagram-login',
    'twitter',
    'twitter-login',
    'linkedin',
    'linkedin-login',
    'microsoft',
    'microsoft-login',
    'outlook',
    'outlook-login',
    'yahoo',
    'yahoo-login',
    'gmail',
    'gmail-login',
    'hotmail',
    'hotmail-login',
    
    // Crypto and investment scams
    'crypto',
    'cryptocurrency',
    'bitcoin',
    'ethereum',
    'wallet',
    'exchange',
    'investment',
    'invest',
    'trading',
    'forex',
    'stock',
    'stocks',
    'broker',
    'brokerage',
    
    // Financial pressure tactics
    'loan',
    'credit',
    'debt',
    'money',
    'cash',
    'payment',
    'pay',
    'billing',
    'invoice',
    'refund',
    'refunds',
    'charge',
    'charges',
    'fee',
    'fees',
    'tax',
    'taxes',
    'irs',
    'irs-login',
    
    // Urgency and pressure tactics
    'free',
    'win',
    'winner',
    'prize',
    'prizes',
    'lottery',
    'lotteries',
    'gift',
    'gifts',
    'offer',
    'offers',
    'discount',
    'discounts',
    'sale',
    'sales',
    'urgent',
    'immediate',
    'action',
    'required',
    'expires',
    'expiring',
    'limited',
    'time',
    'deadline',
    'today',
    'now',
    'asap',
    'hurry',
    'rush',
    'quick',
    'fast',
    
    // Account security threats
    'verify',
    'verification',
    'confirm',
    'confirmation',
    'update',
    'updates',
    'updating',
    'suspended',
    'suspend',
    'locked',
    'lock',
    'unlock',
    'expired',
    'expire',
    'security',
    'secure',
    'breach',
    'breached',
    'compromised',
    'compromise',
    'hacked',
    'hacking',
    'stolen',
    'stole',
    'unauthorized',
    'access',
    'account',
    'accounts',
    'profile',
    'profiles',
    'settings',
    'privacy',
    'personal',
    'information',
    'data',
    'details',
    'credentials',
    'username',
    'email',
    'phone',
    'address',
    'ssn',
    'social',
    'security',
    'number',
    'card',
    'cards',
    'credit-card',
    'debit-card',
    'visa',
    'mastercard',
    'amex',
    'american-express',
    
    // Suspicious file extensions
    '.exe',
    '.bat',
    '.cmd',
    '.scr',
    '.pif',
    '.com',
    '.zip',
    '.rar',
    '.7z',
    '.tar',
    '.gz',
    '.bz2',
    '.iso',
    '.dmg',
    '.pkg',
    '.deb',
    '.rpm',
    '.msi',
    '.app',
    '.apk',
    '.ipa',
    '.jar',
    '.war',
    '.ear',
    '.jsp',
    '.php',
    '.asp',
    '.aspx',
    '.jsp',
    '.cgi',
    '.pl',
    '.py',
    '.rb',
    '.sh',
    '.ps1',
    '.vbs',
    '.js',
    '.html',
    '.htm',
    '.xml',
    '.json',
    '.csv',
    '.txt',
    '.doc',
    '.docx',
    '.pdf',
    '.xls',
    '.xlsx',
    '.ppt',
    '.pptx',
    '.odt',
    '.ods',
    '.odp',
    '.rtf',
    '.wpd',
    '.wps',
    '.pages',
    '.numbers',
    '.keynote',
    '.indd',
    '.ai',
    '.psd',
    '.sketch',
    '.figma',
    '.xd',
    '.canva',
    '.gimp',
    '.inkscape',
    '.blender',
    '.maya',
    '.3ds',
    '.max',
    '.c4d',
    '.fbx',
    '.obj',
    '.dae',
    '.3dm',
    '.3dmf',
    '.x3d',
    '.ply',
    '.stl',
    '.off',
    '.dxf',
    '.dwg',
    '.step',
    '.iges',
    '.stp',
    '.igs',
    '.brep',
    '.sat',
    '.x_t',
    '.x_b',
    '.prt',
    '.asm',
    '.drw',
    '.frm',
    '.skp',
    '.sketchup',
    '.3dm',
    '.3dmf',
    '.x3d',
    '.ply',
    '.stl',
    '.off',
    '.dxf',
    '.dwg',
    '.step',
    '.iges',
    '.stp',
    '.igs',
    '.brep',
    '.sat',
    '.x_t',
    '.x_b',
    '.prt',
    '.asm',
    '.drw',
    '.frm',
    '.skp',
    '.sketchup',
  ];

  static const List<String> _trustedDomains = [
    'google.com',
    'youtube.com',
    'facebook.com',
    'instagram.com',
    'twitter.com',
    'linkedin.com',
    'github.com',
    'stackoverflow.com',
    'wikipedia.org',
    'amazon.com',
    'apple.com',
    'microsoft.com',
    'adobe.com',
    'netflix.com',
    'spotify.com',
    'reddit.com',
    'medium.com',
    'quora.com',
    'pinterest.com',
    'tumblr.com',
    'flickr.com',
    'vimeo.com',
    'dailymotion.com',
    'twitch.tv',
    'discord.com',
    'slack.com',
    'zoom.us',
    'dropbox.com',
    'onedrive.com',
    'google.com',
    'youtube.com',
    'facebook.com',
    'instagram.com',
    'twitter.com',
    'linkedin.com',
    'github.com',
    'stackoverflow.com',
    'wikipedia.org',
    'amazon.com',
    'apple.com',
    'microsoft.com',
    'adobe.com',
    'netflix.com',
    'spotify.com',
    'reddit.com',
    'medium.com',
    'quora.com',
    'pinterest.com',
    'tumblr.com',
    'flickr.com',
    'vimeo.com',
    'dailymotion.com',
    'twitch.tv',
    'discord.com',
    'slack.com',
    'zoom.us',
    'dropbox.com',
    'onedrive.com',
  ];

  static Future<URLValidationResult> validateURL(String url) async {
    try {
      // Clean and normalize URL
      String cleanUrl = _cleanUrl(url);
      
      // Check if URL is valid
      if (!_isValidUrl(cleanUrl)) {
        return URLValidationResult(
          isSafe: false,
          riskLevel: RiskLevel.high,
          message: 'Invalid URL format',
          details: 'The provided URL is not in a valid format.',
        );
      }

      // Extract domain
      String domain = _extractDomain(cleanUrl);
      
      // Check against trusted domains
      if (_trustedDomains.contains(domain.toLowerCase())) {
        return URLValidationResult(
          isSafe: true,
          riskLevel: RiskLevel.low,
          message: 'This URL appears to be from a trusted source',
          details: 'The domain is in our trusted list.',
        );
      }

      // Check for suspicious patterns
      int suspiciousScore = 0;
      List<String> warnings = [];

      // Check for suspicious URL shorteners
      if (_suspiciousPatterns.any((pattern) => domain.toLowerCase().contains(pattern))) {
        suspiciousScore += 3;
        warnings.add('URL shortener detected');
      }

      // Check for suspicious keywords in URL
      String urlLower = cleanUrl.toLowerCase();
      for (String keyword in _suspiciousKeywords) {
        if (urlLower.contains(keyword)) {
          suspiciousScore += 2;
          warnings.add('Suspicious keyword: $keyword');
        }
      }

      // Check for multiple subdomains (potential phishing)
      int subdomainCount = domain.split('.').length;
      if (subdomainCount > 3) {
        suspiciousScore += 2;
        warnings.add('Multiple subdomains detected');
      }

      // Check for IP address instead of domain
      if (RegExp(r'^\d+\.\d+\.\d+\.\d+$').hasMatch(domain)) {
        suspiciousScore += 2;
        warnings.add('IP address instead of domain name');
      }

      // Check for mixed case (potential spoofing)
      if (domain != domain.toLowerCase() && domain != domain.toUpperCase()) {
        suspiciousScore += 1;
        warnings.add('Mixed case domain (potential spoofing)');
      }

      // Check for very long domain
      if (domain.length > 50) {
        suspiciousScore += 1;
        warnings.add('Unusually long domain name');
      }

      // Check for suspicious character patterns
      if (RegExp(r'[^\w\-\.]').hasMatch(domain)) {
        suspiciousScore += 2;
        warnings.add('Suspicious characters in domain');
      }

      // Check for homograph attacks (lookalike characters)
      if (_hasHomographAttack(domain)) {
        suspiciousScore += 4;
        warnings.add('Potential homograph attack detected');
      }

      // Check for typosquatting (common misspellings)
      if (_isTyposquatting(domain)) {
        suspiciousScore += 3;
        warnings.add('Potential typosquatting detected');
      }

      // Check for suspicious file extensions
      if (_hasSuspiciousFileExtension(cleanUrl)) {
        suspiciousScore += 3;
        warnings.add('Suspicious file extension detected');
      }

      // Check for excessive numbers in domain
      if (RegExp(r'\d{4,}').hasMatch(domain)) {
        suspiciousScore += 1;
        warnings.add('Excessive numbers in domain');
      }

      // Check for suspicious TLD patterns
      if (_hasSuspiciousTLD(domain)) {
        suspiciousScore += 2;
        warnings.add('Suspicious top-level domain');
      }

      // Check for URL encoding attempts
      if (cleanUrl.contains('%')) {
        suspiciousScore += 1;
        warnings.add('URL encoding detected');
      }

      // Check for excessive special characters
      int specialCharCount = RegExp(r'[^a-zA-Z0-9\-\.]').allMatches(cleanUrl).length;
      if (specialCharCount > 5) {
        suspiciousScore += 1;
        warnings.add('Excessive special characters');
      }

      // Try to resolve the URL (basic connectivity check)
      try {
        final response = await http.head(Uri.parse(cleanUrl)).timeout(
          const Duration(seconds: 5),
        );
        
        if (response.statusCode >= 400) {
          suspiciousScore += 1;
          warnings.add('URL returns error status: ${response.statusCode}');
        }
      } catch (e) {
        suspiciousScore += 2;
        warnings.add('URL is not accessible');
      }

      // Determine risk level and safety
      RiskLevel riskLevel;
      bool isSafe;
      String message;

      if (suspiciousScore >= 5) {
        riskLevel = RiskLevel.high;
        isSafe = false;
        message = '⚠️ HIGH RISK: This URL appears to be suspicious!';
      } else if (suspiciousScore >= 3) {
        riskLevel = RiskLevel.medium;
        isSafe = false;
        message = '⚠️ MEDIUM RISK: This URL may be suspicious.';
      } else if (suspiciousScore >= 1) {
        riskLevel = RiskLevel.low;
        isSafe = true;
        message = '✅ LOW RISK: This URL appears to be safe.';
      } else {
        riskLevel = RiskLevel.low;
        isSafe = true;
        message = '✅ SAFE: This URL appears to be legitimate.';
      }

      return URLValidationResult(
        isSafe: isSafe,
        riskLevel: riskLevel,
        message: message,
        details: warnings.isNotEmpty ? warnings.join(', ') : 'No issues detected.',
        suspiciousScore: suspiciousScore,
      );
    } catch (e) {
      return URLValidationResult(
        isSafe: false,
        riskLevel: RiskLevel.high,
        message: 'Error validating URL',
        details: 'An error occurred while validating the URL: $e',
      );
    }
  }

  static String _cleanUrl(String url) {
    // Remove whitespace
    url = url.trim();
    
    // Add protocol if missing
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    
    return url;
  }

  static bool _isValidUrl(String url) {
    try {
      Uri.parse(url);
      return true;
    } catch (e) {
      return false;
    }
  }

  static String _extractDomain(String url) {
    try {
      Uri uri = Uri.parse(url);
      return uri.host;
    } catch (e) {
      return '';
    }
  }

  // Check for homograph attacks (lookalike characters)
  static bool _hasHomographAttack(String domain) {
    // Common homograph characters that look like regular letters
    final homographChars = RegExp(r'[а-яё]|[α-ω]|[０-９]|[ａ-ｚ]|[Ａ-Ｚ]');
    return homographChars.hasMatch(domain);
  }

  // Check for typosquatting (common misspellings of popular domains)
  static bool _isTyposquatting(String domain) {
    final popularDomains = [
      'google', 'facebook', 'amazon', 'apple', 'microsoft', 'netflix',
      'youtube', 'twitter', 'instagram', 'linkedin', 'github', 'paypal',
      'ebay', 'walmart', 'target', 'bestbuy', 'homedepot', 'lowes',
      'bankofamerica', 'wellsfargo', 'chase', 'citi', 'usbank',
      'visa', 'mastercard', 'americanexpress', 'discover'
    ];

    final domainLower = domain.toLowerCase();
    for (String popularDomain in popularDomains) {
      if (_calculateLevenshteinDistance(domainLower, popularDomain) <= 2 && 
          domainLower.length >= popularDomain.length - 2) {
        return true;
      }
    }
    return false;
  }

  // Calculate Levenshtein distance for typosquatting detection
  static int _calculateLevenshteinDistance(String s1, String s2) {
    if (s1 == s2) return 0;
    if (s1.isEmpty) return s2.length;
    if (s2.isEmpty) return s1.length;

    List<List<int>> matrix = List.generate(
      s1.length + 1,
      (i) => List.generate(s2.length + 1, (j) => 0),
    );

    for (int i = 0; i <= s1.length; i++) {
      matrix[i][0] = i;
    }
    for (int j = 0; j <= s2.length; j++) {
      matrix[0][j] = j;
    }

    for (int i = 1; i <= s1.length; i++) {
      for (int j = 1; j <= s2.length; j++) {
        int cost = s1[i - 1] == s2[j - 1] ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1,      // deletion
          matrix[i][j - 1] + 1,      // insertion
          matrix[i - 1][j - 1] + cost // substitution
        ].reduce((a, b) => a < b ? a : b);
      }
    }

    return matrix[s1.length][s2.length];
  }

  // Check for suspicious file extensions
  static bool _hasSuspiciousFileExtension(String url) {
    final suspiciousExtensions = [
      '.exe', '.bat', '.cmd', '.scr', '.pif', '.com', '.zip', '.rar',
      '.7z', '.tar', '.gz', '.bz2', '.iso', '.dmg', '.pkg', '.deb',
      '.rpm', '.msi', '.app', '.apk', '.ipa', '.jar', '.war', '.ear'
    ];

    final urlLower = url.toLowerCase();
    return suspiciousExtensions.any((ext) => urlLower.contains(ext));
  }

  // Check for suspicious TLD patterns
  static bool _hasSuspiciousTLD(String domain) {
    final suspiciousTLDs = [
      '.tk', '.ml', '.ga', '.cf', '.click', '.download', '.exe',
      '.zip', '.rar', '.pdf', '.doc', '.xls', '.ppt', '.txt'
    ];

    final domainLower = domain.toLowerCase();
    return suspiciousTLDs.any((tld) => domainLower.endsWith(tld));
  }
}

class URLValidationResult {
  final bool isSafe;
  final RiskLevel riskLevel;
  final String message;
  final String details;
  final int suspiciousScore;

  URLValidationResult({
    required this.isSafe,
    required this.riskLevel,
    required this.message,
    required this.details,
    this.suspiciousScore = 0,
  });
}

enum RiskLevel {
  low,
  medium,
  high,
}
