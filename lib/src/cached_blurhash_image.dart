import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:cached_blurhash/cached_blurhash.dart';

const _DEFAULT_SIZE = 32;

class CachedBlurhashImage extends ImageProvider<CachedBlurhashImage> {
  /// Creates an object that decodes a [blurHash] as an image.
  ///
  /// The arguments must not be null.
  const CachedBlurhashImage(this.blurHash,
      {this.decodingWidth = _DEFAULT_SIZE,
      this.decodingHeight = _DEFAULT_SIZE,
      this.scale = 1.0});

  /// The bytes to decode into an image.
  final String blurHash;

  /// The scale to place in the [ImageInfo] object of the image.
  final double scale;

  /// Decoding definition
  final int decodingWidth;

  /// Decoding definition
  final int decodingHeight;

  @override
  Future<CachedBlurhashImage> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture<CachedBlurhashImage>(this);

  @override
  ImageStreamCompleter loadImage(
          CachedBlurhashImage key, ImageDecoderCallback decode) =>
      OneFrameImageStreamCompleter(_loadAsync(key));

  Future<ImageInfo> _loadAsync(CachedBlurhashImage key) async {
    assert(key == this);

    final image = await cachedBlurhashDecodeImage(
      blurHash: blurHash,
      width: decodingWidth,
      height: decodingHeight,
    );
    return ImageInfo(image: image, scale: key.scale);
  }

  @override
  bool operator ==(Object other) => other.runtimeType != runtimeType
      ? false
      : other is CachedBlurhashImage &&
          other.blurHash == blurHash &&
          other.scale == scale;

  @override
  int get hashCode => Object.hash(blurHash.hashCode, scale);

  @override
  String toString() => '$runtimeType($blurHash, scale: $scale)';
}
