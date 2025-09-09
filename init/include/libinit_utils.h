/*
 * Copyright (C) 2021 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#ifndef LIBINIT_UTILS_H
#define LIBINIT_UTILS_H

#include <string>

void property_override(const std::string& name, const std::string& value);

void property_override_dual(char const prop[], char const system_prop[],
    const std::string& value);

void ro_prop_override(char const source[], char const prop[],
    const std::string& value, bool product = false);

#endif // LIBINIT_UTILS_H
