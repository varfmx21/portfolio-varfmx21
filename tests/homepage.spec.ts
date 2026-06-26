// @ts-check
import { test, expect } from '@playwright/test'

/**
 * Homepage Tests
 * Tests for the main page of portfolio varfmx21
 */

test.describe('Homepage', () => {

  test.beforeEach(async ({ page }) => {

    await page.goto('/');
  });
  
  test('should display the page title', async ({ page }) => {

    await expect(page).toHaveTitle(/varfmx21/);
  });

  test('Should links of navbar works', async ({ page }) => {

    const link = page.getByRole('link', { name: 'Home' });
    await expect(link).toHaveAttribute('href', '/#top');
  });

});