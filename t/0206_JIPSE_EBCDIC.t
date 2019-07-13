######################################################################
#
# 0206_JIPSE_EBCDIC.t
#
# Copyright (c) 2018 INABA Hitoshi <ina@cpan.org> in a CPAN
######################################################################

# iDIVO Ver.1.4.0
# https://www.hulft.com/shukka/files/iDIVO/SP-DV1-CC-02-01.pdf

use strict;
use FindBin;
use lib "$FindBin::Bin/../lib";

BEGIN { $|=1; print "1..512\n"; my $testno=1; sub ok { print $_[0]?'ok ':'not ok ',$testno++,$_[1]?" - $_[1]\n":"\n" }}

my %EBCDIC_NEC_by_JIS8 = map { sprintf('%02X',$_) => (qw(
    00 10 40 F0 7C D7 79 75 20 30 B1 58 91 A5 B2 DC
    01 11 4F F1 C1 D8 57 76 21 31 41 81 92 A6 B3 DD
    02 12 7F F2 C2 D9 59 77 22 1A 42 82 93 A7 B4 DE
    03 13 7B F3 C3 E2 62 78 23 33 43 83 94 A8 B5 DF
    37 3C E0 F4 C4 E3 63 80 24 34 44 84 95 A9 B6 EA
    2D 3D 6C F5 C5 E4 64 8B 25 35 45 85 96 AA B7 EB
    2E 32 50 F6 C6 E5 65 9B 06 36 46 86 97 AC B8 EC
    2F 26 7D F7 C7 E6 66 9C 17 08 47 87 98 AD B9 ED
    16 18 4D F8 C8 E7 67 A0 28 38 48 88 99 AE CA EE
    05 19 5D F9 C9 E8 68 AB 29 39 49 89 9A AF CB EF
    15 3F 5C 7A D1 E9 69 B0 2A 3A 51 8A 9D BA CC FA
    0B 27 4E 5E D2 4A 70 C0 2B 3B 52 8C 9E BB CD FB
    0C 1C 6B 4C D3 5B 71 6A 2C 04 53 8D 9F BC CE FC
    0D 1D 60 7E D4 5A 72 D0 09 14 54 8E A2 BD CF FD
    0E 1E 4B 6E D5 5F 73 A1 0A 3E 55 8F A3 BE DA FE
    0F 1F 61 6F D6 6D 74 07 1B E1 56 90 A4 BF DB FF
))[ ($_%16)*16+int($_/16) ]} (0..255);

my %JIS8_by_EBCDIC_NEC = map { sprintf('%02X',$_) => (qw(
    00 10 80 90 20 26 2D 6B 74 BF 78 7A 7B 7D 24 30
    01 11 81 91 A1 AA 2F 6C B1 C0 7E A0 41 4A 9F 31
    02 12 82 16 A2 AB 63 6D B2 C1 CD E0 42 4B 53 32
    03 13 83 93 A3 AC 64 6E B3 C2 CE E1 43 4C 54 33
    9C 9D 84 94 A4 AD 65 6F B4 C3 CF E2 44 4D 55 34
    09 0A 85 95 A5 AE 66 70 B5 C4 D0 E3 45 4E 56 35
    86 08 17 96 A6 AF 67 71 B6 C5 D1 E4 46 4F 57 36
    7F 87 1B 04 A7 61 68 72 B7 C6 D2 E5 47 50 58 37
    97 18 88 98 A8 B0 69 73 B8 C7 D3 E6 48 51 59 38
    8D 19 89 99 A9 62 6A 60 B9 C8 D4 E7 49 52 5A 39
    8E 92 8A 9A 5B 5D 7C 3A BA C9 D5 DA E8 EE F4 FA
    0B 8F 8B 9B 2E 5C 2C 23 75 76 79 DB E9 EF F5 FB
    0C 1C 8C 14 3C 2A 25 40 BB 77 D6 DC EA F0 F6 FC
    0D 1D 05 15 28 29 5F 27 BC CA D7 DD EB F1 F7 FD
    0E 1E 06 9E 2B 3B 3E 3D BD CB D8 DE EC F2 F8 FE
    0F 1F 07 1A 21 5E 3F 22 BE CC D9 DF ED F3 F9 FF
))[ ($_%16)*16+int($_/16) ]} (0..255);

if (scalar(keys %EBCDIC_NEC_by_JIS8) != 256) {
    die;
}

if (scalar(keys %JIS8_by_EBCDIC_NEC) != 256) {
    die;
}

for (0..255) {
    my $hex = sprintf('%02X',$_);
    if (not exists $JIS8_by_EBCDIC_NEC{$hex}) {
        die;
    }
    if (not defined $JIS8_by_EBCDIC_NEC{$hex}) {
        die;
    }
    if ($EBCDIC_NEC_by_JIS8{$JIS8_by_EBCDIC_NEC{$hex}} ne $hex) {
        die "\$hex=($hex) \$JIS8_by_EBCDIC_NEC{$hex}=($JIS8_by_EBCDIC_NEC{$hex}) \$EBCDIC_NEC_by_JIS8{$JIS8_by_EBCDIC_NEC{$hex}}=($EBCDIC_NEC_by_JIS8{$JIS8_by_EBCDIC_NEC{$hex}})";
    }
}

for (0..255) {
    my $hex = sprintf('%02X',$_);
    if (not exists $EBCDIC_NEC_by_JIS8{$hex}) {
        die;
    }
    if (not defined $EBCDIC_NEC_by_JIS8{$hex}) {
        die;
    }
    if ($JIS8_by_EBCDIC_NEC{$EBCDIC_NEC_by_JIS8{$hex}} ne $hex) {
        die "\$hex=($hex) \$EBCDIC_NEC_by_JIS8{$hex}=($EBCDIC_NEC_by_JIS8{$hex}) \$JIS8_by_EBCDIC_NEC{$EBCDIC_NEC_by_JIS8{$hex}}=($JIS8_by_EBCDIC_NEC{$EBCDIC_NEC_by_JIS8{$hex}})";
    }
}

# JIPS(J) --> JIPS(E) table
# http://ameblo.jp/geckoman/entry-11634710872.html
my @jtoe = (
    0x00,0x01,0x02,0x03,0x37,0x2D,0x2E,0x2F,0x16,0x05,0x15,0x0B,0x0C,0x0D,0x0E,0x0F, # 0
    0x10,0x11,0x12,0x13,0x3C,0x3D,0x32,0x26,0x18,0x19,0x3F,0x27,0x1C,0x1D,0x1E,0x1F, # 1
    0x40,0x4F,0x7F,0x7B,0xE0,0x6C,0x50,0x7D,0x4D,0x5D,0x5C,0x4E,0x6B,0x60,0x4B,0x61, # 2
    0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0x7A,0x5E,0x4C,0x7E,0x6E,0x6F, # 3
    0x7C,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6, # 4
    0xD7,0xD8,0xD9,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0x4A,0x5B,0x5A,0x5F,0x6D, # 5
    0x79,0x57,0x59,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x70,0x71,0x72,0x73,0x74, # 6
    0x75,0x76,0x77,0x78,0x80,0x8B,0x9B,0x9C,0xA0,0xAB,0xB0,0xC0,0x6A,0xD0,0xA1,0x00, # 7
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, # 8
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, # 9
    0x00,0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x51,0x52,0x53,0x54,0x55,0x56, # A
    0x58,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8C,0x8D,0x8E,0x8F,0x90, # B
    0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9D,0x9E,0x9F,0xA2,0xA3,0xA4, # C
    0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAC,0xAD,0xAE,0xAF,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, # D
    0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xDA,0xDB, # E
    0xDC,0xDD,0xDE,0xDF,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,0xFA,0xFB,0xFC,0xFD,0xFE,0x00, # F
);

# JIPS(E) --> JIPS(J) table
# http://ameblo.jp/geckoman/entry-11634710872.html
my @etoj = (
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, # 0
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, # 1
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, # 2
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00, # 3
    0x00,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0x5B,0x2E,0x3C,0x28,0x2B,0x21, # 4
    0x26,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0x61,0xB0,0x62,0x5D,0x5C,0x2A,0x29,0x3B,0x5E, # 5
    0x2D,0x2F,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x7C,0x2C,0x25,0x5F,0x3E,0x3F, # 6
    0x6B,0x6C,0x6D,0x6E,0x6F,0x70,0x71,0x72,0x73,0x60,0x3A,0x23,0x40,0x27,0x3D,0x22, # 7
    0x74,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0x75,0xBB,0xBC,0xBD,0xBE, # 8
    0xBF,0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0x76,0x77,0xCA,0xCB,0xCC, # 9
    0x78,0x7E,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0x79,0xD6,0xD7,0xD8,0xD9, # A
    0x7A,0x00,0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, # B
    0x7B,0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0xE8,0xE9,0xEA,0xEB,0xEC,0xED, # C
    0x7D,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,0x52,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3, # D
    0x24,0x00,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9, # E
    0x30,0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0xFA,0xFB,0xFC,0xFD,0xFE,0x00, # F
);

for (0..255) {
    my $hex = sprintf('%02X',$_);
    if ($jtoe[$_] == 0x00) {
    }
    elsif ($EBCDIC_NEC_by_JIS8{$hex} ne sprintf('%02X',$jtoe[$_])) {
        die sprintf("\$EBCDIC_NEC_by_JIS8{$hex}(=$EBCDIC_NEC_by_JIS8{$hex}) is not '%02X' at %02X", $jtoe[$_], $_);
    }
}

for (0..255) {
    my $hex = sprintf('%02X',$_);
    if ($etoj[$_] == 0x00) {
    }
    elsif ($JIS8_by_EBCDIC_NEC{$hex} ne sprintf('%02X',$etoj[$_])) {
        die sprintf("\$JIS8_by_EBCDIC_NEC{$hex}(=$JIS8_by_EBCDIC_NEC{$hex}) is not '%02X' at %02X", $etoj[$_], $_);
    }
}

my %jis2ebcdic_nec = qw(
    20 40
    21 4F
    22 7F
    23 7B
    24 E0
    25 6C
    26 50
    27 7D
    28 4D
    29 5D
    2A 5C
    2B 4E
    2C 6B
    2D 60
    2E 4B
    2F 61
    30 F0
    31 F1
    32 F2
    33 F3
    34 F4
    35 F5
    36 F6
    37 F7
    38 F8
    39 F9
    3A 7A
    3B 5E
    3C 4C
    3D 7E
    3E 6E
    3F 6F
    40 7C
    41 C1
    42 C2
    43 C3
    44 C4
    45 C5
    46 C6
    47 C7
    48 C8
    49 C9
    4A D1
    4B D2
    4C D3
    4D D4
    4E D5
    4F D6
    50 D7
    51 D8
    52 D9
    53 E2
    54 E3
    55 E4
    56 E5
    57 E6
    58 E7
    59 E8
    5A E9
    5B 4A
    5C 5B
    5D 5A
    5E 5F
    5F 6D
    60 79
    61 57
    62 59
    63 62
    64 63
    65 64
    66 65
    67 66
    68 67
    69 68
    6A 69
    6B 70
    6C 71
    6D 72
    6E 73
    6F 74
    70 75
    71 76
    72 77
    73 78
    74 80
    75 8B
    76 9B
    77 9C
    78 A0
    79 AB
    7A B0
    7B C0
    7C 6A
    7D D0
    7E A1
    A0 B1
    A1 41
    A2 42
    A3 43
    A4 44
    A5 45
    A6 46
    A7 47
    A8 48
    A9 49
    AA 51
    AB 52
    AC 53
    AD 54
    AE 55
    AF 56
    B0 58
    B1 81
    B2 82
    B3 83
    B4 84
    B5 85
    B6 86
    B7 87
    B8 88
    B9 89
    BA 8A
    BB 8C
    BC 8D
    BD 8E
    BE 8F
    BF 90
    C0 91
    C1 92
    C2 93
    C3 94
    C4 95
    C5 96
    C6 97
    C7 98
    C8 99
    C9 9A
    CA 9D
    CB 9E
    CC 9F
    CD A2
    CE A3
    CF A4
    D0 A5
    D1 A6
    D2 A7
    D3 A8
    D4 A9
    D5 AA
    D6 AC
    D7 AD
    D8 AE
    D9 AF
    DA BA
    DB BB
    DC BC
    DD BD
    DE BE
    DF BF
);

for my $jis (sort keys %jis2ebcdic_nec) {
    if ($EBCDIC_NEC_by_JIS8{$jis} ne $jis2ebcdic_nec{$jis}) {
        die "jis($jis): ($EBCDIC_NEC_by_JIS8{$jis}) ne ($jis2ebcdic_nec{$jis})";
    }
}

use Jacode4e;

for my $byte (0x00 .. 0xFF) {
    my $give = pack('C',$byte);
    my $got  = pack('C',$byte);
    my $want = pack('H*',EBCDIC_NEC_by_JIS8(uc unpack('H*',$give)));
    my $return = Jacode4e::convert(\$got,'jipse','cp932x',{'INPUT_LAYOUT'=>'S'});
    ok(($return > 0) and ($got eq $want),
        sprintf(qq{cp932x(%s) to jipse(%s) => return=$return,got=(%s)},
            uc unpack('H*',$give),
            uc unpack('H*',$want),
            uc unpack('H*',$got),
        )
    );
}

for my $byte (0x00 .. 0xFF) {
    my $give = pack('C',$byte);
    my $got  = pack('C',$byte);
    my $want = pack('H*',JIS8_by_EBCDIC_NEC(uc unpack('H*',$give)));
    my $return = Jacode4e::convert(\$got,'cp932x','jipse',{'INPUT_LAYOUT'=>'S'});
    ok(($return > 0) and ($got eq $want),
        sprintf(qq{jipse(%s) to cp932x(%s) => return=$return,got=(%s)},
            uc unpack('H*',$give),
            uc unpack('H*',$want),
            uc unpack('H*',$got),
        )
    );
}

sub EBCDIC_NEC_by_JIS8 {
    my($byte) = @_;
    return $EBCDIC_NEC_by_JIS8{$byte};
}

sub JIS8_by_EBCDIC_NEC {
    my($byte) = @_;
    return $JIS8_by_EBCDIC_NEC{$byte};
}

1;

__END__