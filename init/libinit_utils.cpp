/*
 * Copyright (C) 2021 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>
#include <vector>

#include <android-base/logging.h>
#include <android-base/properties.h>
#include <libinit_utils.h>

void property_override(const std::string& name, const std::string& value)
{
    size_t valuelen = value.size();

    prop_info* pi = (prop_info*) __system_property_find(name.c_str());
    if (pi != nullptr) {
        __system_property_update(pi, value.c_str(), valuelen);
    }
    else {
        int rc = __system_property_add(name.c_str(), name.size(), value.c_str(), valuelen);
        if (rc < 0) {
            LOG(ERROR) << "property_set(\"" << name << "\", \"" << value << "\") failed: "
                       << "__system_property_add failed";
        }
    }
}

void property_override_dual(char const prop[], char const system_prop[],
    const std::string& value)
{
    property_override(prop, value);
    property_override(system_prop, value);
}

void ro_prop_override(char const source[], char const prop[],
    const std::string& value, bool product)
{
    std::string prop_name = "ro.";

    if (product) prop_name += "product.";
    if (source != nullptr) prop_name += source;
    if (!product) prop_name += "build.";
    prop_name += prop;

    property_override(prop_name.c_str(), value);
};
