import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/util_crypto/mnemonic.dart';
import 'package:p4d_rust_binding/util_crypto/secp256k1.dart';
import 'package:p4d_rust_binding/util_crypto/types.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

void main() {
  secp256k1Test();
}

void secp256k1Test() {
  test('secp256k1', () {
    const secp256k1Tests = [
      [
        'life fee table ahead modify maximum dumb such tobacco boss dry nurse',
        '0xf2360e871c830d397fe221382b503f07ddd8763df81a94bb2504390a2fb91f59',
        '0x036b0aa6beab469dd2b748a0ff5ddbe3d13df1e15c9d28a2aa057212994e127bea',
        '0xae8e8fcacbaeb607bcdf0bbd7e615f2b4ef484ee54f19d68a7393fb6db2dd9cd'
      ],
      [
        'tide survey cradle cover column ugly author wait eye state elder blame',
        '0x5385355a5118ec732b9dbcf1668ba21db38b07cf79082dafa9a7cc4b52e4abb0',
        '0x03929e4f93cdad265751ad8f6365185d8e937610d19b510400f5867d542d60a313',
        '0xf80ea815da66c42f870b687e1530770d5a7936ae81a147b009506d85bd6d621c'
      ],
      [
        'laugh fish flee cake approve butter april dynamic myth license ticket lobster',
        '0x83ec65cf9a8a7442d808aef6f8987599f1ba3be880769bb3a20621b13adbd476',
        '0x0388299e4cfaa33d180a026bd54a46ad98df129a131320a9d2fd6f80e64bc3db39',
        '0x35036238dd195f4c2169379354bda6cba5746f67bde03ef59a77a4cea80729bc'
      ],
      [
        'animal thing fork recipe exotic pilot inquiry pledge obey slab obtain reveal',
        '0x0fd50580eb5a58b0eee60c77656dffa50094b539262366f1227d3babfd7343e5',
        '0x036edc954685ad89f0a23b0fb1eb2b9c3a8600eee9091c758426dfb2bc7889a7c3',
        '0x2a94b10d1f28810dc4628e7e424b2d08bd3d17fb08f9416d112f17e86c8fa77c'
      ]
    ];

    var singleTest = hexToU8a('0x4380de832af797688026ce24f85204d508243f201650c1a134929e5458b7fbae');
    var singleResult = KeyPair.fromMap({
      "publicKey": hexToU8a('0x03fd8c74f795ced92064b86191cb2772b1e3a0947740aa0a5a6e379592471fd85b'),
      "secretKey": hexToU8a('0x4380de832af797688026ce24f85204d508243f201650c1a134929e5458b7fbae')
    });
    expect(secp256k1KeypairFromSeed(singleTest).toJson(), singleResult.toJson());

    secp256k1Tests.forEach((t) {
      var phrase = t[0];
      var sk = t[1];
      var pk = t[2];
      var seed = mnemonicToMiniSecret(phrase);
      var pair = secp256k1KeypairFromSeed(seed);
      expect(u8aToHex(pair.secretKey), sk);
      expect(u8aToHex(pair.publicKey), pk);
    });
    print("\n");
  });
}
