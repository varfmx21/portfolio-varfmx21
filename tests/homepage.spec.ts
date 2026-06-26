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

});