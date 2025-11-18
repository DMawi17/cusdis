# Amharic Language Setup for Cusdis Widget

## Overview
The Cusdis widget now supports Amharic language with the following translations:

### Labels:
- **ስም** (Name)
- **ኢሜል** (Email)
- **አስተያየት** (Comment)

### Placeholders:
- **ስሞትን ይፃፉ** (Enter your name)
- **ኢሜሎትን ይፃፉ** (Enter your email)
- **አስተያየትዎን ይፃፉ** (Enter your comment)

## How to Enable Amharic

Add this script to your website **before** the Cusdis widget script:

```html
<script>
  window.CUSDIS_LOCALE = {
    powered_by: 'የአስተያየት አገልግሎት በ Cusdis',
    post_comment: 'አስተያየት ይስጡ',
    loading: 'በመጫን ላይ',

    // Labels
    email: 'ኢሜል',
    nickname: 'ስም',
    comment_label: 'አስተያየት',

    // Placeholders
    email_placeholder: 'ኢሜሎትን ይፃፉ',
    nickname_placeholder: 'ስሞትን ይፃፉ',
    comment_placeholder: 'አስተያየትዎን ይፃፉ',

    // Buttons and actions
    reply_placeholder: 'መልስ...',
    reply_btn: 'መልስ',
    sending: 'በመላክ ላይ...',

    // Validation and messages
    mod_badge: 'አስተዳዳሪ',
    content_is_required: 'አስተያየት ያስፈልጋል',
    nickname_is_required: 'ስም ያስፈልጋል',
    comment_has_been_sent: 'አስተያየትዎ ተልኳል። እባክዎን ለማረጋገጥ ይጠብቁ።',
  };
</script>

<!-- Then load your Cusdis widget -->
<div id="cusdis_thread"
  data-host="https://your-cusdis-instance.railway.app"
  data-app-id="your-app-id"
  data-page-id="{{ PAGE_ID }}"
  data-page-url="{{ PAGE_URL }}"
  data-page-title="{{ PAGE_TITLE }}"
></div>
<script async defer src="https://your-cusdis-instance.railway.app/js/cusdis.es.js"></script>
```

## Alternative: Load from Language File

You can also load the Amharic language file directly:

```html
<script>
  // Load Amharic translations
  import('/js/widget/lang/am.js').then(module => {
    window.CUSDIS_LOCALE = module.default;
  });
</script>
```

## Language File Location

The Amharic language file is located at:
- Source: `widget/lang/am.js`
- Built: `public/js/widget/lang/am.js`

## Customization

You can customize any translation by modifying the `window.CUSDIS_LOCALE` object. Only include the keys you want to override - missing keys will fall back to English.

Example (customize only the submit button):
```html
<script>
  window.CUSDIS_LOCALE = {
    post_comment: 'ያስገቡ', // Custom submit button text
  };
</script>
```
