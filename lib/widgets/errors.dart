import 'package:flutter/material.dart';

class ErrorViews {
  ErrorViews._();

  static Widget noInternet({VoidCallback? onRetry}) {
    return _errorWidget(
      icon: Icons.wifi_off_rounded,
      title: "No Internet",
      message: "Please check your internet connection and try again.",
      buttonText: "Retry",
      onPressed: onRetry,
    );
  }

  static Widget timeout({VoidCallback? onRetry}) {
    return _errorWidget(
      icon: Icons.timer_off_outlined,
      title: "Request Timed Out",
      message: "The server took too long to respond.",
      buttonText: "Retry",
      onPressed: onRetry,
    );
  }

  static Widget serverError({VoidCallback? onRetry}) {
    return _errorWidget(
      icon: Icons.cloud_off_outlined,
      title: "Server Error",
      message: "Something went wrong on the server.",
      buttonText: "Try Again",
      onPressed: onRetry,
    );
  }

  static Widget unauthorized({VoidCallback? onRetry}) {
    return _errorWidget(
      icon: Icons.lock_outline,
      title: "Authentication Failed",
      message: "Invalid API key or authentication failed.",
      buttonText: "Retry",
      onPressed: onRetry,
    );
  }

  static Widget forbidden() {
    return _errorWidget(
      icon: Icons.block,
      title: "Access Denied",
      message: "You don't have permission to access this resource.",
    );
  }

  static Widget notFound() {
    return _errorWidget(
      icon: Icons.search_off,
      title: "No Results Found",
      message: "We couldn't find anything matching your search.",
    );
  }

  static Widget empty() {
    return _errorWidget(
      icon: Icons.inbox_outlined,
      title: "No Data Available",
      message: "Nothing to display right now.",
    );
  }

  static Widget invalidResponse() {
    return _errorWidget(
      icon: Icons.error_outline,
      title: "Invalid Response",
      message: "The server returned an unexpected response.",
    );
  }

  static Widget unknown({VoidCallback? onRetry}) {
    return _errorWidget(
      icon: Icons.warning_amber_rounded,
      title: "Something Went Wrong",
      message: "An unexpected error occurred.",
      buttonText: "Retry",
      onPressed: onRetry,
    );
  }

  static Widget loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static Widget _errorWidget({
    required IconData icon,
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            if (buttonText != null) ...[
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: onPressed,
                child: Text(buttonText),
              ),
            ]
          ],
        ),
      ),
    );
  }
}