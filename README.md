# Fraud Shield App

A Flutter application that helps protect users from malicious QR codes and suspicious links through AI-powered analysis and safety warnings.

## Features

### 🔍 QR Code Scanner
- Real-time QR code scanning with camera integration
- Automatic URL detection and validation
- Animated scanning interface with visual feedback
- Support for both URL and text QR codes

### 🔗 URL Safety Checker
- Manual URL input with clipboard paste support
- AI-powered suspicious link detection
- Real-time URL validation and risk assessment
- Support for URL shorteners and suspicious patterns

### 🛡️ Safety Results
- **Safe URLs**: Green indicators with "You are safe" message
- **Dangerous URLs**: Red warnings with "You are going to be trapped" message
- Detailed risk analysis and security tips
- Animated warnings with modern UI

### 🎨 Modern UI/UX
- Beautiful gradient backgrounds
- Smooth animations and transitions
- Material Design 3 components
- Responsive design for all screen sizes

## Screenshots

The app includes:
- **Home Screen**: Main dashboard with navigation options
- **QR Scanner**: Camera-based QR code scanning
- **URL Checker**: Manual URL input and validation
- **Safety Results**: Detailed analysis with safety warnings

## Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Permissions

The app requires the following permissions:
- **Camera**: For QR code scanning
- **Internet**: For URL validation and analysis
- **Network State**: For connectivity checks

## Dependencies

- `mobile_scanner`: QR code scanning
- `url_launcher`: Opening safe URLs
- `http`: Network requests for URL validation
- `lottie`: Animations
- `animated_text_kit`: Text animations
- `permission_handler`: Camera permissions

## How It Works

1. **QR Scanning**: Point camera at QR code to scan and analyze
2. **URL Checking**: Paste or type URLs to check for safety
3. **Analysis**: AI-powered detection of suspicious patterns
4. **Results**: Clear safety warnings with detailed information

## Safety Features

- Detection of URL shorteners (bit.ly, tinyurl.com, etc.)
- Suspicious keyword analysis
- Domain reputation checking
- Phishing pattern recognition
- Malware URL detection
- Mixed case domain spoofing detection

## Risk Levels

- **LOW RISK**: Safe to open (Green)
- **MEDIUM RISK**: Proceed with caution (Orange)
- **HIGH RISK**: Dangerous - avoid opening (Red)

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is licensed under the MIT License.