# Netaj — Google Tag Manager Template

Official GTM Community Template for [Netaj](https://netaj.io), the AB testing, heatmaps, session recordings, and conversion rate optimization platform.

## Installation

1. In Google Tag Manager, go to **Templates** → **Search Gallery**
2. Search for **"Netaj"**
3. Click **Add to workspace**
4. Create a new **Tag** → select **Netaj**
5. Enter your **Organization ID** (e.g. `nj_a1b2c3d4`)
6. Set the trigger to **All Pages**
7. **Publish** your container

## Finding Your Organization ID

1. Log in to [app.netaj.io](https://app.netaj.io)
2. Go to **Settings** → **Websites**
3. Your Organization ID is displayed at the top (format: `nj_xxxxxxxx`)

## What This Template Does

- Loads the Netaj tracking script on your website
- Automatically detects which website the data belongs to based on the hostname
- Only collects data for websites that are verified in your Netaj dashboard
- Sets up the `window.netaj()` command queue for custom event tracking

## Custom Events

After the tag is installed, you can track custom events:

```javascript
window.netaj.track('purchase_complete', {
  value: 99.99,
  currency: 'SAR'
});
```

## Ecommerce Tracking

```javascript
window.netaj.ecommerce.addToCart({ id: 'SKU-123', name: 'T-Shirt', price: 29.99 });
window.netaj.ecommerce.purchase({ orderId: 'ORD-456', total: 89.97 });
```

## Support

- [Documentation](https://netaj.io/en/docs)
- [Issues](https://github.com/creativeworks/netaj-gtm-template/issues)
- [Website](https://netaj.io)

## License

Apache 2.0
