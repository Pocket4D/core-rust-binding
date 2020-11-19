import 'package:laksadart/laksadart.dart';
import 'package:p4d_rust_binding/crypto/common.dart';
import 'package:p4d_rust_binding/p4d_rust_binding.dart';

class Secp256k1 {
  String _keypair;
  String _privateKey;
  String _publicKey;

  String get keyPair => _keypair;
  String get private => _privateKey;
  String get public => _publicKey;

  static getPubFromPrivate(String privateKey) {
    return hexAddPrefix(secp256k1GetPubFromPrivate(privateKey));
  }

  static getCompressPublic(String publicKey) {
    return hexAddPrefix(secp256k1GetCompressPub(publicKey));
  }

  Secp256k1.fromSeed(dynamic seed) {
    if (isString(seed) && isHexString(seed) && isPrivateKey(seed)) {
      _privateKey = hexAddPrefix(seed);
    } else if (isU8a(seed) && seed.length == 32) {
      _privateKey = u8aToHex(seed, include0x: true);
    }
    if (!isPrivateKey(_privateKey)) {
      throw "Error: Secp256k1 $_privateKey is not valid publicKey";
    }
    _publicKey = hexAddPrefix(Secp256k1.getPubFromPrivate(_privateKey));
    if (!isPublicKey(_publicKey)) {
      throw "Error: Secp256k1 $_publicKey is not valid publicKey";
    }
    _keypair = hexAddPrefix(hexStripPrefix(_privateKey) + hexStripPrefix(_publicKey));
  }

  KeyPair toKeyPair() => KeyPair(publicKey: hexToU8a(public), secretKey: hexToU8a(private));
}
