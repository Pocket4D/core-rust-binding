const defs = {
  "rpc": {
    "epochAuthorship": {
      "description":
          "Returns data about which slots (primary or secondary) can be claimed in the current epoch with the keys in the keystore",
      "params": [],
      "type": "HashMap<AuthorityId, EpochAuthorship>"
    }
  },
  "types": {
    "AllowedSlots": {
      "_enum": ["PrimarySlots", "PrimaryAndSecondaryPlainSlots", "PrimaryAndSecondaryVRFSlots"]
    },
    "BabeAuthorityWeight": "u64",
    "BabeBlockWeight": "u32",
    "BabeEquivocationProof": {
      "offender": "AuthorityId",
      "slotNumber": "SlotNumber",
      "firstHeader": "Header",
      "secondHeader": "Header"
    },
    "BabeWeight": "u64",
    "MaybeRandomness": "Option<Randomness>",
    "MaybeVrf": "Option<VrfData>",
    "EpochAuthorship": {
      "primary": "Vec<u64>",
      "secondary": "Vec<u64>",
      "secondary_vrf": "Vec<u64>"
    },
    "NextConfigDescriptor": {
      "_enum": {"V0": "Null", "V1": "NextConfigDescriptorV1"}
    },
    "NextConfigDescriptorV1": {"c": "(u64, u64)", "allowedSlots": "AllowedSlots"},
    "Randomness": "Hash",
    "RawBabePreDigest": {
      "_enum": {
        "Phantom": "Null",
        "Primary": "RawBabePreDigestPrimary",
        "SecondaryPlain": "RawBabePreDigestSecondaryPlain",
        "SecondaryVRF": "RawBabePreDigestSecondaryVRF"
      }
    },
    "RawBabePreDigestPrimary": {
      "authorityIndex": "u32",
      "slotNumber": "SlotNumber",
      "vrfOutput": "VrfOutput",
      "vrfProof": "VrfProof"
    },
    "RawBabePreDigestSecondaryPlain": {"authorityIndex": "u32", "slotNumber": "SlotNumber"},
    "RawBabePreDigestSecondaryVRF": {
      "authorityIndex": "u32",
      "slotNumber": "SlotNumber",
      "vrfOutput": "VrfOutput",
      "vrfProof": "VrfProof"
    },
    "RawBabePreDigestTo159": {
      "_enum": {
        "Primary": "RawBabePreDigestPrimaryTo159",
        "Secondary": "RawBabePreDigestSecondaryTo159"
      }
    },
    "RawBabePreDigestPrimaryTo159": {
      "authorityIndex": "u32",
      "slotNumber": "SlotNumber",
      "weight": "BabeBlockWeight",
      "vrfOutput": "VrfOutput",
      "vrfProof": "VrfProof"
    },
    "RawBabePreDigestSecondaryTo159": {
      "authorityIndex": "u32",
      "slotNumber": "SlotNumber",
      "weight": "BabeBlockWeight"
    },
    "RawBabePreDigestCompat": {
      "_enum": {"Zero": "u32", "One": "u32", "Two": "u32", "Three": "u32"}
    },
    "SlotNumber": "u64",
    "VrfData": "[u8; 32]",
    "VrfOutput": "[u8; 32]",
    "VrfProof": "[u8; 64]"
  }
};
