#!/usr/bin/env bash
# Base16 Bespin - Mate Terminal color scheme install script
# Jan T. Sott

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Bespin Dark"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-bespin-dark"
[[ -z "$DCONFTOOL" ]] && DCONFTOOL=dconf
[[ -z "$BASE_KEY" ]] && BASE_KEY=/org/mate/terminal/profiles

PROFILE_KEY="$BASE_KEY/$PROFILE_SLUG"

dset() {
  local key="$1"; shift
  local val="$1"; shift

  "$DCONFTOOL" write "$PROFILE_KEY/$key" "$val"
}

# Because gconftool doesn't have "append"
glist_append() {
  local key="$1"; shift
  local val="$1"; shift

  local entries="$(
    {
      "$DCONFTOOL" read "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
      echo "'$val'"
    } | head -c-1 | tr "\n" ,
  )"

  "$DCONFTOOL" write "$key" "[$entries]"
}

# Append the Base16 profile to the profile list
glist_append /org/mate/terminal/global/profile-list "$PROFILE_SLUG"

dset visible-name "'$PROFILE_NAME'"
dset palette "'#28211c:#cf6a4c:#54be0d:#f9ee98:#5ea6ea:#9b859d:#afc4db:#8a8986:#666666:#cf6a4c:#54be0d:#f9ee98:#5ea6ea:#9b859d:#afc4db:#baae9e'"
dset background-color "'#28211c'"
dset foreground-color "'#8a8986'"
dset bold-color "'#8a8986'"
dset bold-color-same-as-fg "true"
dset use-theme-colors "false"
dset use-theme-background "false"
