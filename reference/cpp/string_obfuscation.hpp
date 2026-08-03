#pragma once
#include <cstdint>
#include <array>
#include <utility>

namespace obfuscation {

template<std::size_t N>
class ObfuscatedString {
private:
    std::array<uint8_t, N> data;
    static constexpr uint8_t KEY = 0xAA;

    constexpr void encrypt() {
        for (std::size_t i = 0; i < N - 1; ++i) {
            data[i] ^= (KEY + i);
        }
    }

public:
    constexpr ObfuscatedString(const char (&str)[N]) {
        for (std::size_t i = 0; i < N; ++i) {
            data[i] = static_cast<uint8_t>(str[i]);
        }
        encrypt();
    }

    const char* decrypt() const {
        auto* mutable_data = const_cast<uint8_t*>(data.data());
        for (std::size_t i = 0; i < N - 1; ++i) {
            mutable_data[i] ^= (KEY + i);
        }
        return reinterpret_cast<const char*>(mutable_data);
    }

    void re_encrypt() const {
        auto* mutable_data = const_cast<uint8_t*>(data.data());
        for (std::size_t i = 0; i < N - 1; ++i) {
            mutable_data[i] ^= (KEY + i);
        }
    }

    std::size_t size() const { return N - 1; }
};

template<std::size_t N>
constexpr auto make_obfuscated(const char (&str)[N]) {
    return ObfuscatedString<N>(str);
}

class ScopedDecrypt {
private:
    const ObfuscatedString<256>* str_ptr;
public:
    ScopedDecrypt(const ObfuscatedString<256>& str) : str_ptr(&str) {
        str_ptr->decrypt();
    }
    ~ScopedDecrypt() {
        str_ptr->re_encrypt();
    }
};

}

#define OBFUSCATE(str) obfuscation::make_obfuscated(str)
